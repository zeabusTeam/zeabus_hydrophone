/****************************************************************************
 * zeabus_flash.c
 *
 * Zeabus firmware for EZ-USB FX3 Microcontrollers
 * Copyright (C) 2019-2020 Zeabus Term, Kasetsart University.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name NuttX nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/
#include <cyu3system.h>
#include <cyu3os.h>
#include <cyu3spi.h>
#include <cyu3dma.h>
#include <cyu3error.h>

#include "zeabus.h"
#include "zeabus_flash.h"

/*
 * The firmware uses DMA to transfer data from and to the SPI flash
 * There are 2 simple-DMA channels, each for reading and writing data.
 * These channels operates in "Manual IN channel" and "Manual OUT channel".
 */

/****************************************************************************
 * DMA layer
 ****************************************************************************/
static CyU3PDmaChannel xSpiTxHandle, xSpiRxHandle;

static bool zeabus_spidma_initialize( void )
{
    CyU3PDmaChannelConfig_t dmaConfig;

    // DMA channels for SPI write 
    CyU3PMemSet ((uint8_t *)&dmaConfig, 0, sizeof(dmaConfig));
    dmaConfig.size           = FLASH_PAGE_SIZE;     /* Buffer size (aka. dma transferring unit) */
    dmaConfig.count          = 0;   /* We don't allocate any buffer at the moment */
    dmaConfig.prodAvailCount = 0;   /* Always 0 */
    dmaConfig.dmaMode        = CY_U3P_DMA_MODE_BYTE;

    /* We don't have any header and footer fields within data tranferred. */
    dmaConfig.prodHeader     = 0;
    dmaConfig.prodFooter     = 0;
    dmaConfig.consHeader     = 0;

    dmaConfig.notification   = 0;       /* No DMA notification (we use polling, anyway) */
    dmaConfig.cb             = NULL;    /* No callback function */

    /* Channel to write to SPI flash. */
    dmaConfig.prodSckId = CY_U3P_CPU_SOCKET_PROD;
    dmaConfig.consSckId = CY_U3P_LPP_SOCKET_SPI_CONS;
    if ( CyU3PDmaChannelCreate (&xSpiTxHandle, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaConfig) != CY_U3P_SUCCESS )
        return false;

    /* Channel to read from SPI flash. */
    dmaConfig.prodSckId = CY_U3P_LPP_SOCKET_SPI_PROD;
    dmaConfig.consSckId = CY_U3P_CPU_SOCKET_CONS;
    if ( CyU3PDmaChannelCreate (&xSpiRxHandle, CY_U3P_DMA_TYPE_MANUAL_IN, &dmaConfig) != CY_U3P_SUCCESS )
        return false;

    return true;
}

/* Activate DMA for reading. Return successfully read size */
static uint32_t zeabus_spidma_read( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t t_buf;
    uint32_t    read_size;  /* size of successfully read data */
    
    read_size = 0;
    t_buf.buffer = buf;
    t_buf.status = 0;
    
    /* Loop transferring with the size each as FLASH_PAGE_SIZE 
     * since t_buf.size is uint16_t but we have "size" as uint32_t.
     * Therefore, we need to be careful. */
    while ( size > 0 ) 
    {
        if( size > FLASH_PAGE_SIZE )
        {
            t_buf.size = FLASH_PAGE_SIZE;
            size -= FLASH_PAGE_SIZE;
        }
        else
        {
            t_buf.size = (uint16_t)size;
            size = 0;
        }
        t_buf.count = t_buf.size;

        /* Rounding t_buf.size to multiple of 16 (required by the system) */
        if( t_buf.size % 16 != 0 )
        {
            t_buf.size &= 0xFFF0;   /* Discard fraction */
            t_buf.size += 16;       /* Rounding up the whole */
        }

        /* Initiate DMA mode */
        if( CyU3PSpiSetBlockXfer (0, (uint32_t)(t_buf.size) ) != CY_U3P_SUCCESS )
            break;

        /* Setup and start DMA operation */
        if ( CyU3PDmaChannelSetupRecvBuffer (&xSpiRxHandle, &t_buf) != CY_U3P_SUCCESS )
            break;
    
        /* Waiting 500ms for DMA to complete. The tranferring should finish within this time */
        if( CyU3PDmaChannelWaitForCompletion (&xSpiRxHandle, 500) != CY_U3P_SUCCESS )
        {
            CyU3PDmaChannelReset (&xSpiRxHandle);
            CyU3PSpiDisableBlockXfer (CyFalse, CyTrue);
            return read_size;
        }
        CyU3PSpiDisableBlockXfer (CyFalse, CyTrue);
        
        t_buf.buffer += (uint32_t)(t_buf.size);
        read_size += (uint32_t)(t_buf.size);
    }

    /* Finish */
    return read_size;
}

/* Activate DMA for writing. Return successfully written size */
static uint32_t zeabus_spidma_write( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t t_buf;
    uint32_t written_size;      /* Amount of successfully written data */

    written_size = 0;
    t_buf.buffer = buf;
    t_buf.status = 0;
    
    /* Loop transferring with the size each as FLASH_PAGE_SIZE 
     * since t_buf.size is uint16_t but we have "size" as uint32_t.
     * Therefore, we need to be careful. */
    while ( size > 0 ) 
    {
        if( size > FLASH_PAGE_SIZE )
        {
            t_buf.size = FLASH_PAGE_SIZE;
            size -= FLASH_PAGE_SIZE;
        }
        else
        {
            t_buf.size = (uint16_t)size;
            size = 0;
        }
        t_buf.count = t_buf.size;

        /* Rounding t_buf.size to multiple of 16 (required by the system) */
        if( t_buf.size % 16 != 0 )
        {
            t_buf.size &= 0xFFF0;   /* Discard fraction */
            t_buf.size += 16;       /* Rounding up the whole */
        }

        /* Initiate DMA mode */
        if( CyU3PSpiSetBlockXfer ( (uint32_t)(t_buf.size), 0 ) != CY_U3P_SUCCESS )
            break;

        /* Setup and start DMA operation */
        if ( CyU3PDmaChannelSetupSendBuffer (&xSpiTxHandle, &t_buf) != CY_U3P_SUCCESS )
            break;
    
        /* Waiting 500ms for DMA to complete. The tranferring should finish within this time */
        if( CyU3PDmaChannelWaitForCompletion (&xSpiTxHandle, 500) != CY_U3P_SUCCESS )
        {
            CyU3PDmaChannelReset (&xSpiTxHandle);
            CyU3PSpiDisableBlockXfer (CyTrue, CyFalse);
            return written_size;
        }
        CyU3PSpiDisableBlockXfer (CyTrue, CyFalse);
        
        t_buf.buffer += (uint32_t)(t_buf.size);
        written_size += (uint32_t)(t_buf.size);
    }

    /* Finish */
    return written_size;
}

/****************************************************************************
 * SPI layer
 ****************************************************************************/
static inline bool zeabus_spi_cs_on( void )
{
    if( CyU3PSpiSetSsnLine(CyFalse) == CY_U3P_SUCCESS )
        return true;
    else
        return false;
}

static inline bool zeabus_spi_cs_off( void )
{
    if( CyU3PSpiSetSsnLine(CyTrue) == CY_U3P_SUCCESS )
        return true;
    else
        return false;
}

static bool zeabus_spi_initialize( void )
{
    CyU3PSpiConfig_t spiConfig;

    if( CyU3PSpiInit() != CY_U3P_SUCCESS )
        return false;

    /* Start the SPI master block  */
    CyU3PMemSet ( (uint8_t *)&spiConfig, 0, sizeof(spiConfig) );
//    spiConfig.clock      = 33000000;
    spiConfig.clock      = 50000000UL;  /* Clock freq. in Hz */
    spiConfig.isLsbFirst = CyFalse;     /* Data are sent MSB first */
    spiConfig.ssnPol     = CyFalse;     /* CS polariy (active low) */
    spiConfig.cpol       = CyTrue;      /* Clock polarity (idle = High) */
    spiConfig.cpha       = CyTrue;      /* Slave samples data at rising edge. */
    spiConfig.leadTime   = CY_U3P_SPI_SSN_LAG_LEAD_HALF_CLK; /* Time from holding CS line to 1 data bit */
    spiConfig.lagTime    = CY_U3P_SPI_SSN_LAG_LEAD_HALF_CLK; /* Time from last data bit to releasing CS */
    spiConfig.ssnCtrl    = CY_U3P_SPI_SSN_CTRL_FW; /* CS line is controlled by the firmware through spi lib */
    spiConfig.wordLen    = 8;
    if( CyU3PSpiSetConfig (&spiConfig, NULL) != CY_U3P_SUCCESS )
        return false;
    else
        return true;
}

/****************************************************************************
 * Flash operation layer
 ****************************************************************************/

/* Some Flash commands */
#define _FLASH_CMD_SECTOR_ERASE     (0xD8)
#define _FLASH_CMD_PAGE_WRITE       (0x02)
#define _FLASH_CMD_FAST_READ        (0x0B)
#define _FLASH_CMD_READ_STATUS1     (0x05)
#define _FLASH_CMD_READ_STATUS2     (0x07)
#define _FLASH_CMD_READ_CONFIG      (0x35)
#define _FLASH_CMD_WRITE_ENABLE     (0x06)
#define _FLASH_CMD_WRITE_DISABLE    (0x04)
#define _FLASH_CMD_WRITE_REG        (0x01)

/* Status register 1 field mask */
#define _FLASH_SR1_ENABLE_WP_PIN    (0x80)
#define _FLASH_SR1_PROGRAMMING_ERR  (0x40)
#define _FLASH_SR1_ERASING_ERR      (0x20)
#define _FLASH_SR1_AREA_PROTEC_MODE (0x1C)  /* 3 bits */
#define _FLASH_SR1_REG_WRITE_ENABLE (0x02)
#define _FLASH_SR1_FLASH_BUSY       (0x01)

static uint8_t au8FlashCmdCell[4];          /* Data buffer for non-DMA commands */

/* Wait for current operation to finish */
static bool zeabus_spi_flash_wait_busy()
{
    au8FlashCmdCell[0] = _FLASH_CMD_READ_STATUS1;
    if( !zeabus_spi_cs_on() )
        return false;

    if ( CyU3PSpiTransmitWords( au8FlashCmdCell, 1 ) != CY_U3P_SUCCESS)
    {
        (void)zeabus_spi_cs_off();
        return false;
    }
    
    for (int i=0; i < 11000; i++) /* wait up to 11s */
    {  
        if ( CyU3PSpiReceiveWords (au8FlashCmdCell, 1) != CY_U3P_SUCCESS )
        {
            (void)zeabus_spi_cs_off();
            return false;
        }
        if ( ( au8FlashCmdCell[0] & _FLASH_SR1_FLASH_BUSY) == 0 )
        {
            break;  /* Device is not busy now */
        }
        CyU3PThreadSleep(1);    /* Sleep for 1 ms */
    }

    return( zeabus_spi_cs_off() ); 
}

/* Enable writing to flash. The flash always disables writing after each 
 * erasing or writing.
 */
static bool zeabus_spi_flash_write_en( void )
{
    au8FlashCmdCell[0] = _FLASH_CMD_WRITE_ENABLE;
    if( !zeabus_spi_cs_on() )
        return false;

    if( CyU3PSpiTransmitWords(au8FlashCmdCell, 1) == CY_U3P_SUCCESS )
    {
        return( zeabus_spi_cs_off() );
    }
    else
    {
        (void)zeabus_spi_cs_off();
        return false;
    }
}

/****************************************************************************
 * Public API
 ****************************************************************************/

/* Read a chuck of data from flash.
 * Return the amount of successfully read.
 */
uint32_t zeabus_spi_flash_read( uint32_t addr, uint8_t* buf, uint32_t size )
{
    uint32_t s_size;    /* Successfully read size */

    s_size = 0;

    /* If the device is busy then wait */
    if ( !zeabus_spi_flash_wait_busy() )
        return 0UL;       /* Error */
    
    /* Send Flash Fast-read command */
    au8FlashCmdCell[0] =_FLASH_CMD_FAST_READ;
    au8FlashCmdCell[1] = (uint8_t)( ( addr >> 16 ) & 0xFF );
    au8FlashCmdCell[2] = (uint8_t)( ( addr >> 8 ) & 0xFF );
    au8FlashCmdCell[3] = (uint8_t)( addr & 0xFF );
    if( !zeabus_spi_cs_on() )
        return 0UL;
    if( CyU3PSpiTransmitWords( au8FlashCmdCell, 4 ) != CY_U3P_SUCCESS )
    {
        (void)zeabus_spi_cs_off();
        return 0;
    }

    /* Read data */
    s_size = zeabus_spidma_read( buf, size );
    
    /* De-assert CS */
    (void)zeabus_spi_cs_off();

    return s_size;
}

/* Write pages of data to flash. The unit of writing is in the number of pages.
 * Flash architecture allows writing only in page unit.
 * The function does not verify data availability. The caller must be sure to
 * have enough data in the provided buffer.
 * Return the total written pages. */
uint16_t zeabus_spi_flash_page_write( uint16_t page, uint8_t* buf, uint16_t total )
{
    uint32_t t;
    uint16_t s;    /* Successfully written size */

    s = 0;

    /* If the device is busy then wait */
    if ( !zeabus_spi_flash_wait_busy() )
        return 0;       /* Error */

    /* Looping to erase flash sectors */
    while( total > 0 )
    {
        if( !zeabus_spi_flash_write_en() )
            break;

        /* Page writing command */
        au8FlashCmdCell[0] = _FLASH_CMD_PAGE_WRITE;
        au8FlashCmdCell[1] = (uint8_t)( ( page >> 8 ) & 0xFF );
        au8FlashCmdCell[2] = (uint8_t)( page & 0xFF );
        au8FlashCmdCell[3] = 0;
        if( !zeabus_spi_cs_on() )
            break;
        if( CyU3PSpiTransmitWords ( au8FlashCmdCell, 4 ) != CY_U3P_SUCCESS )
        {
            /* Erasing failed!! */
            (void)zeabus_spi_cs_off();
            break;
        }

        /* Transferring 1 page */
        t = zeabus_spidma_write( buf, FLASH_PAGE_SIZE );

        /* Successfully issueing command, then wait. */
        if( !zeabus_spi_cs_off() )
            break;

        if( t > 0 )
        {
            if( !zeabus_spi_flash_wait_busy() )
                break;
        }

        /* Advance to the next page */
        buf += FLASH_PAGE_SIZE;
        s++;
        page++;
        total--;
        /* If we cannot successfully perfromed full page write, then finish */
        if( t != FLASH_PAGE_SIZE )  
            break;
    }

    return s;
}

/* Erase specifed contigous sectors. Return the total successfully erased sectors.
 * Flash archtecture allows erasing only in sector unit. */
uint8_t zeabus_spi_flash_erase_sector( uint8_t sector, uint8_t total )
{
    uint8_t s;  /* Total erased sectors so far */

    s = 0;

    /* Wait for any on-process work */
    if( !zeabus_spi_flash_wait_busy() )
        return 0;

    /* Looping to erase flash sectors */
    while( total > 0 )
    {
        if( !zeabus_spi_flash_write_en() )
            break;

        /* Sector-erasing command */
        au8FlashCmdCell[0] = _FLASH_CMD_SECTOR_ERASE;
        au8FlashCmdCell[1] = sector;
        au8FlashCmdCell[2] = 0;
        au8FlashCmdCell[3] = 0;
        if( !zeabus_spi_cs_on() )
            break;
        if( CyU3PSpiTransmitWords ( au8FlashCmdCell, 4 ) != CY_U3P_SUCCESS )
        {
            /* Erasing failed!! */
            (void)zeabus_spi_cs_off();
            break;
        }

        /* Successfully issueing command, then wait. */
        if( !zeabus_spi_cs_off() )
            break;

        if( !zeabus_spi_flash_wait_busy() )
            break;

        /* Advance to the next sector */
        s++;
        sector++;
        total--;
    }

    return s;
}

bool zeabus_spi_flash_initialize( void )
{
    if( !zeabus_spi_initialize() )
        return false;
    if( !zeabus_spidma_initialize() )
        return false;

    return true;
}
