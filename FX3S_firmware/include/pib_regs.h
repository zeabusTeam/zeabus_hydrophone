/*
 ## Cypress FX3 Core Library Header (pib_regs.h)
 ## ===========================
 ##
 ##  Copyright Cypress Semiconductor Corporation, 2010-2018,
 ##  All Rights Reserved
 ##  UNPUBLISHED, LICENSED SOFTWARE.
 ##
 ##  CONFIDENTIAL AND PROPRIETARY INFORMATION
 ##  WHICH IS THE PROPERTY OF CYPRESS.
 ##
 ##  Use of this file is governed
 ##  by the license agreement included in the file
 ##
 ##     <install>/license/license.txt
 ##
 ##  where <install> is the Cypress software
 ##  installation root directory path.
 ##
 ## ===========================
 */

#ifndef _INCLUDED_PIB_REGS_H_
#define _INCLUDED_PIB_REGS_H_

#include <cyu3types.h>

#include <gpif_regs.h>

#define PIB_BASE_ADDR                            (0xe0010000)

typedef struct
{
    uvint32_t config;                             /* 0xe0010000 */
    uvint32_t intr;                               /* 0xe0010004 */
    uvint32_t intr_mask;                          /* 0xe0010008 */
    uvint32_t clock_detect;                       /* 0xe001000c */
    uvint32_t rd_mailbox0;                        /* 0xe0010010 */
    uvint32_t rd_mailbox1;                        /* 0xe0010014 */
    uvint32_t wr_mailbox0;                        /* 0xe0010018 */
    uvint32_t wr_mailbox1;                        /* 0xe001001c */
    uvint32_t error;                              /* 0xe0010020 */
    uvint32_t eop_eot;                            /* 0xe0010024 */
    uvint32_t dll_ctrl;                           /* 0xe0010028 */
    uvint32_t rsrvd0[4085];
    uvint32_t gpif_config;                        /* 0xe0014000 */
    uvint32_t gpif_bus_config;                    /* 0xe0014004 */
    uvint32_t gpif_bus_config2;                   /* 0xe0014008 */
    uvint32_t gpif_ad_config;                     /* 0xe001400c */
    uvint32_t gpif_status;                        /* 0xe0014010 */
    uvint32_t gpif_intr;                          /* 0xe0014014 */
    uvint32_t gpif_intr_mask;                     /* 0xe0014018 */
    uvint32_t gpif_serial_in_config;              /* 0xe001401c */
    uvint32_t gpif_serial_out_config;             /* 0xe0014020 */
    uvint32_t gpif_ctrl_bus_direction;            /* 0xe0014024 */
    uvint32_t gpif_ctrl_bus_default;              /* 0xe0014028 */
    uvint32_t gpif_ctrl_bus_polarity;             /* 0xe001402c */
    uvint32_t gpif_ctrl_bus_toggle;               /* 0xe0014030 */
    uvint32_t gpif_ctrl_bus_select[16];           /* 0xe0014034 */
    uvint32_t gpif_ctrl_count_config;             /* 0xe0014074 */
    uvint32_t gpif_ctrl_count_reset;              /* 0xe0014078 */
    uvint32_t gpif_ctrl_count_limit;              /* 0xe001407c */
    uvint32_t gpif_addr_count_config;             /* 0xe0014080 */
    uvint32_t gpif_addr_count_reset;              /* 0xe0014084 */
    uvint32_t gpif_addr_count_limit;              /* 0xe0014088 */
    uvint32_t gpif_state_count_config;            /* 0xe001408c */
    uvint32_t gpif_state_count_limit;             /* 0xe0014090 */
    uvint32_t gpif_data_count_config;             /* 0xe0014094 */
    uvint32_t gpif_data_count_reset;              /* 0xe0014098 */
    uvint32_t gpif_data_count_limit;              /* 0xe001409c */
    uvint32_t gpif_ctrl_comp_value;               /* 0xe00140a0 */
    uvint32_t gpif_ctrl_comp_mask;                /* 0xe00140a4 */
    uvint32_t gpif_data_comp_value;               /* 0xe00140a8 */
    uvint32_t gpif_data_comp_mask;                /* 0xe00140ac */
    uvint32_t gpif_addr_comp_value;               /* 0xe00140b0 */
    uvint32_t gpif_addr_comp_mask;                /* 0xe00140b4 */
    uvint32_t gpif_data_ctrl;                     /* 0xe00140b8 */
    uvint32_t gpif_ingress_data[4];               /* 0xe00140bc */
    uvint32_t gpif_egress_data[4];                /* 0xe00140cc */
    uvint32_t gpif_ingress_address[4];            /* 0xe00140dc */
    uvint32_t gpif_egress_address[4];             /* 0xe00140ec */
    uvint32_t gpif_thread_config[4];              /* 0xe00140fc */
    uvint32_t gpif_lambda_stat;                   /* 0xe001410c */
    uvint32_t gpif_alpha_stat;                    /* 0xe0014110 */
    uvint32_t gpif_beta_stat;                     /* 0xe0014114 */
    uvint32_t gpif_waveform_ctrl_stat;            /* 0xe0014118 */
    uvint32_t gpif_waveform_switch;               /* 0xe001411c */
    uvint32_t gpif_waveform_switch_timeout;       /* 0xe0014120 */
    uvint32_t gpif_crc_config;                    /* 0xe0014124 */
    uvint32_t gpif_crc_data;                      /* 0xe0014128 */
    uvint32_t gpif_beta_deassert;                 /* 0xe001412c */
    uvint32_t gpif_function[32];                  /* 0xe0014130 */
    uvint32_t rsrvd1[916];
    struct
    {
        uvint32_t waveform0;                      /* 0xe0015000 */
        uvint32_t waveform1;                      /* 0xe0015004 */
        uvint32_t waveform2;                      /* 0xe0015008 */
        uvint32_t waveform3;                      /* 0xe001500c */
    } gpif_left[256];
    struct
    {
        uvint32_t waveform0;                      /* 0xe0016000 */
        uvint32_t waveform1;                      /* 0xe0016004 */
        uvint32_t waveform2;                      /* 0xe0016008 */
        uvint32_t waveform3;                      /* 0xe001600c */
    } gpif_right[256];
    uvint32_t rsrvd2[896];
    uvint32_t pp_id;                              /* 0xe0017e00 */
    uvint32_t pp_init;                            /* 0xe0017e04 */
    uvint32_t pp_config;                          /* 0xe0017e08 */
    uvint32_t reserve0[3];
    uvint32_t pp_sock_wr_config;                  /* 0xe0017e18 */
    uvint32_t pp_intr_mask;                       /* 0xe0017e1c */
    uvint32_t pp_drqr5_mask;                      /* 0xe0017e20 */
    uvint32_t pp_sock_mask;                       /* 0xe0017e24 */
    uvint32_t pp_error;                           /* 0xe0017e28 */
    uvint32_t pp_dma_xfer;                        /* 0xe0017e2c */
    uvint32_t pp_dma_size;                        /* 0xe0017e30 */
    uvint32_t pp_wr_mailbox0;                     /* 0xe0017e34 */
    uvint32_t pp_wr_mailbox1;                     /* 0xe0017e38 */
    uvint32_t pp_mmio_addr;                       /* 0xe0017e3c */
    uvint32_t pp_mmio_data;                       /* 0xe0017e40 */
    uvint32_t pp_mmio;                            /* 0xe0017e44 */
    uvint32_t pp_event;                           /* 0xe0017e48 */
    uvint32_t pp_rd_mailbox0;                     /* 0xe0017e4c */
    uvint32_t pp_rd_mailbox1;                     /* 0xe0017e50 */
    uvint32_t pp_sock_stat;                       /* 0xe0017e54 */
    uvint32_t rsrvd3[42];
    uvint32_t id;                                 /* 0xe0017f00 */
    uvint32_t power;                              /* 0xe0017f04 */
    uvint32_t rsrvd4[62];
    struct
    {
        uvint32_t dscr;                           /* 0xe0018000 */
        uvint32_t size;                           /* 0xe0018004 */
        uvint32_t count;                          /* 0xe0018008 */
        uvint32_t status;                         /* 0xe001800c */
        uvint32_t intr;                           /* 0xe0018010 */
        uvint32_t intr_mask;                      /* 0xe0018014 */
        uvint32_t rsrvd5[2];
        uvint32_t dscr_buffer;                    /* 0xe0018020 */
        uvint32_t dscr_sync;                      /* 0xe0018024 */
        uvint32_t dscr_chain;                     /* 0xe0018028 */
        uvint32_t dscr_size;                      /* 0xe001802c */
        uvint32_t rsrvd6[19];
        uvint32_t event;                          /* 0xe001807c */
    } sck[32];
    uvint32_t rsrvd7[7104];
    uvint32_t sck_intr0;                          /* 0xe001ff00 */
    uvint32_t sck_intr1;                          /* 0xe001ff04 */
    uvint32_t sck_intr2;                          /* 0xe001ff08 */
    uvint32_t sck_intr3;                          /* 0xe001ff0c */
    uvint32_t sck_intr4;                          /* 0xe001ff10 */
    uvint32_t sck_intr5;                          /* 0xe001ff14 */
    uvint32_t sck_intr6;                          /* 0xe001ff18 */
    uvint32_t sck_intr7;                          /* 0xe001ff1c */
} PIB_REGS_T, *PPIB_REGS_T;

#define PIB        ((PPIB_REGS_T) PIB_BASE_ADDR)


/*
   PIB Configuration Register
 */
#define CY_U3P_PIB_CONFIG_ADDRESS                           (0xe0010000)
#define CY_U3P_PIB_CONFIG                                   (*(uvint32_t *)(0xe0010000))
#define CY_U3P_PIB_CONFIG_DEFAULT                           (0xe8000000)

/*
   Provides a device ID as defined in IROS. This field is visible in PP_INIT
   registers. This must be provided by boot ROM.  This register is not writable
   when GCTL_CONTROL.BOOTROM_EN=0 to prevent spoofing.
 */
#define CY_U3P_PIB_DEVICE_ID_MASK                           (0x0000ffff) /* <0:15> R:RW:0:No */
#define CY_U3P_PIB_DEVICE_ID_POS                            (0)


/*
   This field specifies Min value for NRC and NCC timing parameters.
   0 - 3 cycles (default)
   1 - 8 cycles
   PMMC HW waits for this minimum period before looking for start bit after
   a prev. command without response or after a previous response.
   The MIN value for NRC & NCC is 8 per MMC specs.
   It has been observed that certain popular APs voilate this min timing
   spec. This config bit fix will allow PMMC HW to work such APs. FW may
   program this field to 1 if NRC/NCC min is desired at 8 cycles.
   It should be noted that with this fix multicard cannot co exisit on PMMC
   bus..
 */
#define CY_U3P_PIB_PMMC_NRC_NCC_MIN8                        (1u << 21) /* <21:21> R:RW:0:No */


/*
   This field specifies PMMC boot timing.
   00 - Default speed
   01 - High Speed
   10 - Reserved
   11 - Reserved
   This field is used in BOOT state after HW reset or CMD0(GO_PRE_IDLE) and
   CMD0(BOOT_INITIATION) command.
 */
#define CY_U3P_PIB_PMMC_BOOT_HS_TIMING_MASK                 (0x00c00000) /* <22:23> R:RW:0:No */
#define CY_U3P_PIB_PMMC_BOOT_HS_TIMING_POS                  (22)


/*
   This field specifies PMMC boot bus width.
   00 - 1 bit
   01 - 4 bit
   10 - 8 bit
   11 - Reserved
   This field is used in BOOT state after HW reset or CMD0(GO_PRE_IDLE) and
   CMD0(BOOT_INITIATION) command.
 */
#define CY_U3P_PIB_PMMC_BOOT_BUSWIDTH_MASK                  (0x03000000) /* <24:25> R:RW:0:No */
#define CY_U3P_PIB_PMMC_BOOT_BUSWIDTH_POS                   (24)


/*
   This bit enables MMC 4.3/4.4 boot if PCFG selects PMMC mode.
   When set PMMC HW will sense MMC4.3/4.4 boot commands. When this bit is
   zero HW ignores boot commands. FW/BootROM sets this bit. FW does not need
   to clear this bit. This field is used by PMMC HW after a HW reset or CMD0(GO_PRE_IDLE)
   to PMMC block
 */
#define CY_U3P_PIB_EMMC_BOOT_ENABLE                         (1u << 26) /* <26:26> R:RW:0:No */


/*
   FW writes 0 to reset PMMC-registers and PMMC-StateMachine. After clearing
   this bit, firmware sets this bit to bring PMMC out of reset. This reset
   will place PMMC in IDLE state.
   
   This reset should NOT be used during CMD0(GO_IDLE) initialization as it
   can corrupt CMD1 command in flight. This reset should be used only for
   error recovery. PMMC HW will clear all necessary registers for CMD0(GO_IDLE)
   iitialization.
 */
#define CY_U3P_PIB_PMMC_RESETN                              (1u << 27) /* <27:27> R:RW:1:No */


/*
   P-Port configuraiton
   0: GPIF-II mode
   1: P-MMC mode
   The BootROM will interpret the PMODE pins through GPIO and choose the
   appropriate GPIF and P-Port configuration.
 */
#define CY_U3P_PIB_PCFG                                     (1u << 28) /* <28:28> R:RW:0:No */


/*
   Variable indicating initialization mode to Application processor (PP_CONFIG.CFGMODE).
    Cleared by firmware after P-Port is properly initialized and ready to
   transact.
 */
#define CY_U3P_PIB_PP_CFGMODE                               (1u << 29) /* <29:29> RW:RW:1:No */


/*
   Enables the PP_MMIO protocol for accessing individual MMIO registers externally
   over P-Port.  Once disabled this function cannot be re-enabled.
   0: Disabled
   1: Enabled
 */
#define CY_U3P_PIB_MMIO_ENABLE                              (1u << 30) /* <30:30> R:RW0C:1:No */


/*
   Enables the entire P-Port IP.
 */
#define CY_U3P_PIB_ENABLE                                   (1u << 31) /* <31:31> R:RW:1:No */



/*
   PIB Interrupt Request Register
 */
#define CY_U3P_PIB_INTR_ADDRESS                             (0xe0010004)
#define CY_U3P_PIB_INTR                                     (*(uvint32_t *)(0xe0010004))
#define CY_U3P_PIB_INTR_DEFAULT                             (0x00000001)

/*
   Indicates that the RD_MAILBOX is empty and a new message can be written.
    This bit sets when AP writes PP_EVENT.RD_MB_FULL=0.  It must be cleared
   by firmware.
 */
#define CY_U3P_PIB_INTR_RD_MB_EMPTY                         (1u << 0) /* <0:0> RW1S:RW1C:1:Yes */


/*
   Indicates that a message is present in WR_MAILBOX and must be read.  This
   bit sets when AP writes a message in the WR_MAILBOX.  It must be cleared
   by firmware and causes  PP_EVENT.WR_MB_EMPTY to assert.
 */
#define CY_U3P_PIB_INTR_WR_MB_FULL                          (1u << 1) /* <1:1> RW1S:RW1C:0:Yes */


/*
   A MMC interrupt has been received.  The specific interrupt received is
   indicated in PMMC_INTR.
 */
#define CY_U3P_PIB_INTR_PMMC_INTR1                          (1u << 3) /* <3:3> W:R :0:No */


/*
   Indicates that the interrupt is from GPIF block. Consult GPIF_STAT register
 */
#define CY_U3P_PIB_INTR_GPIF_INTERRUPT                      (1u << 4) /* <4:4> W:R:0:No */


/*
   DLL has achieved phase lock. Interrupt clears after writing 1.
 */
#define CY_U3P_PIB_INTR_DLL_LOCKED                          (1u << 5) /* <5:5> W1S:RW1C:0:Yes */


/*
   DLL has lost phase lock. Interrupt clears after writing 1.
 */
#define CY_U3P_PIB_INTR_DLL_LOST_LOCK                       (1u << 6) /* <6:6> W1S:RW1C:0:Yes */


/*
   PIB_CLK is no longer present.  See PIB_CLOCK_DETECT for more details.
 */
#define CY_U3P_PIB_INTR_CLOCK_LOST                          (1u << 7) /* <7:7> W1S:RW1C:0:No */


/*
   AP has written a new value into PP_CONFIG
 */
#define CY_U3P_PIB_INTR_CONFIG_CHANGE                       (1u << 8) /* <8:8> W1S:RW1C:0:Yes */


/*
   Indicates that AP has written to PP_WR_THRESHOLD register
 */
#define CY_U3P_PIB_INTR_WR_THRESHOLD                        (1u << 9) /* <9:9> W1S:RW1C:0:Yes */


/*
   Indicates that AP has written to PP_RD_THRESHOLD register
 */
#define CY_U3P_PIB_INTR_RD_THRESHOLD                        (1u << 10) /* <10:10> W1S:RW1C:0:Yes */


/*
   The socket based link controller encountered an error and needs attention.
    FW clears this bit after handling the error.  The error code is indicated
   in PIB_ERROR.PIB_ERR_CODE
 */
#define CY_U3P_PIB_INTR_PIB_ERR                             (1u << 29) /* <29:29> W1S:RW1C:0:Yes */


/*
   An unrecoverable error occurred in the PMMC controller. FW clears this
   bit after handling the eror. The error code is indicated in PIB_ERROR.MMC_ERR_CODE
 */
#define CY_U3P_PIB_INTR_MMC_ERR                             (1u << 30) /* <30:30> W1S:RW1C:0:Yes */


/*
   An error occurred in the GPIF.  FW clears this bit after handling the
   error.  The error code is indicated in PIB_ERROR.GPIF_ERR_CODE
 */
#define CY_U3P_PIB_INTR_GPIF_ERR                            (1u << 31) /* <31:31> W1S:RW1C:0:Yes */



/*
   PIB Interrupt Mask Register
 */
#define CY_U3P_PIB_INTR_MASK_ADDRESS                        (0xe0010008)
#define CY_U3P_PIB_INTR_MASK                                (*(uvint32_t *)(0xe0010008))
#define CY_U3P_PIB_INTR_MASK_DEFAULT                        (0x00000000)

/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_RD_MB_EMPTY                         (1u << 0) /* <0:0> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_WR_MB_FULL                          (1u << 1) /* <1:1> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_PMMC_INTR                           (1u << 3) /* <3:3> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_GPIF_INTERRUPT                      (1u << 4) /* <4:4> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_DLL_LOCKED                          (1u << 5) /* <5:5> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_DLL_LOST_LOCK                       (1u << 6) /* <6:6> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_CLOCK_LOST                          (1u << 7) /* <7:7> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_CONFIG_CHANGE                       (1u << 8) /* <8:8> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_WR_THRESHOLD                        (1u << 9) /* <9:9> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_RD_THRESHOLD                        (1u << 10) /* <10:10> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_PIB_ERR                             (1u << 29) /* <29:29> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_MMC_ERR                             (1u << 30) /* <30:30> R:RW:0:No */


/*
   Mask for corresponding interrupt in PIB_INTR
 */
#define CY_U3P_PIB_INTR_GPIF_ERR                            (1u << 31) /* <31:31> R:RW:0:No */



/*
   PIB Clock detector configuration
 */
#define CY_U3P_PIB_CLOCK_DETECT_ADDRESS                     (0xe001000c)
#define CY_U3P_PIB_CLOCK_DETECT                             (*(uvint32_t *)(0xe001000c))
#define CY_U3P_PIB_CLOCK_DETECT_DEFAULT                     (0x00000000)

/*
   Number of busclk cycles for each measurement period.
 */
#define CY_U3P_PIB_BUS_CYCLES_MASK                          (0x0000ffff) /* <0:15> R:RW:0:No */
#define CY_U3P_PIB_BUS_CYCLES_POS                           (0)


/*
   Minimum number of posedges required on PIBCLK pin to declare clock presence
   during each measurement period.
 */
#define CY_U3P_PIB_INTF_CYCLES_MASK                         (0x000f0000) /* <16:19> R:RW:0:No */
#define CY_U3P_PIB_INTF_CYCLES_POS                          (16)


/*
   Indicates latest clock presence measurement
 */
#define CY_U3P_PIB_CLOCK_PRESENT                            (1u << 30) /* <30:30> RW:R:0:No */


/*
   Enables detector
 */
#define CY_U3P_PIB_ENABLE                                   (1u << 31) /* <31:31> R:RW:0:No */



/*
   Read (Egress) Mailbox Register
 */
#define CY_U3P_PIB_RD_MAILBOX0_ADDRESS                      (0xe0010010)
#define CY_U3P_PIB_RD_MAILBOX0                              (*(uvint32_t *)(0xe0010010))
#define CY_U3P_PIB_RD_MAILBOX0_DEFAULT                      (0x00000000)

/*
   Mailbox message from FX3 to Application Processor.
 */
#define CY_U3P_PIB_PP_RD_MAILBOX_L_MASK                     (0xffffffff) /* <0:31> R:RW:0:No */
#define CY_U3P_PIB_PP_RD_MAILBOX_L_POS                      (0)



/*
   Read (Egress) Mailbox Register
 */
#define CY_U3P_PIB_RD_MAILBOX1_ADDRESS                      (0xe0010014)
#define CY_U3P_PIB_RD_MAILBOX1                              (*(uvint32_t *)(0xe0010014))
#define CY_U3P_PIB_RD_MAILBOX1_DEFAULT                      (0x00000000)

/*
   Mailbox message from FX3 to Application Processor.
 */
#define CY_U3P_PIB_PP_RD_MAILBOX_H_MASK                     (0xffffffff) /* <0:31> R:RW:0:No */
#define CY_U3P_PIB_PP_RD_MAILBOX_H_POS                      (0)



/*
   Write (Ingress) Mailbox Register
 */
#define CY_U3P_PIB_WR_MAILBOX0_ADDRESS                      (0xe0010018)
#define CY_U3P_PIB_WR_MAILBOX0                              (*(uvint32_t *)(0xe0010018))
#define CY_U3P_PIB_WR_MAILBOX0_DEFAULT                      (0x00000000)

/*
   Mailbox message from Application Processor to FX3
 */
#define CY_U3P_PIB_PP_WR_MAILBOX_L_MASK                     (0xffffffff) /* <0:31> RW:R:0:No */
#define CY_U3P_PIB_PP_WR_MAILBOX_L_POS                      (0)



/*
   Write (Ingress) Mailbox Register
 */
#define CY_U3P_PIB_WR_MAILBOX1_ADDRESS                      (0xe001001c)
#define CY_U3P_PIB_WR_MAILBOX1                              (*(uvint32_t *)(0xe001001c))
#define CY_U3P_PIB_WR_MAILBOX1_DEFAULT                      (0x00000000)

/*
   Mailbox message from Application Processor to FX3
 */
#define CY_U3P_PIB_PP_WR_MAILBOX_H_MASK                     (0xffffffff) /* <0:31> RW:R:0:No */
#define CY_U3P_PIB_PP_WR_MAILBOX_H_POS                      (0)



/*
   PIB Error Indicator Register
 */
#define CY_U3P_PIB_ERROR_ADDRESS                            (0xe0010020)
#define CY_U3P_PIB_ERROR                                    (*(uvint32_t *)(0xe0010020))
#define CY_U3P_PIB_ERROR_DEFAULT                            (0x00000000)

/*
   The socket based link controller encountered an error and needs attention.
   Error codes are further described in BROS.  Corresponds to interrupt bit
   PIB_ERROR.
 */
#define CY_U3P_PIB_PIB_ERR_CODE_MASK                        (0x0000003f) /* <0:5> RW:R:0:No */
#define CY_U3P_PIB_PIB_ERR_CODE_POS                         (0)

/*
   Write being done to a Read Socket or Read being done to a write skt
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_DIR_ERROR               (1)
/*
   Write being done to a Read Socket or Read being done to a write skt
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_DIR_ERROR               (2)
/*
   Write being done to a Read Socket or Read being done to a write skt
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_DIR_ERROR               (3)
/*
   Write being done to a Read Socket or Read being done to a write skt
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_DIR_ERROR               (4)
/*
   Write exceeds the space available in the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_WR_OVERFLOW             (5)
/*
   Write exceeds the space available in the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_WR_OVERFLOW             (6)
/*
   Write exceeds the space available in the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_WR_OVERFLOW             (7)
/*
   Write exceeds the space available in the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_WR_OVERFLOW             (8)
/*
   Reads exceeds the byte count of the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_RD_UNDERRUN             (9)
/*
   Reads exceeds the byte count of the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_RD_UNDERRUN             (10)
/*
   Reads exceeds the byte count of the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_RD_UNDERRUN             (11)
/*
   Reads exceeds the byte count of the buffer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_RD_UNDERRUN             (12)
/*
   Socket has gone inactive within a DMA Transfer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_SCK_ACTIVE              (0x12)
/*
   Adapter Unable to service write request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_ADAP_OVERFLOW           (0x13)
/*
   Adapter Unable to service read request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_ADAP_UNDERFLOW          (0x14)
/*
   A Read socket has been wrapped up
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_READ_FORCE_END          (0x15)
/*
   A read socket with burstsize > 0 is switched before 8-byte boundary
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH0_READ_BURST_ERR          (0x16)
/*
   Socket has gone inactive within a DMA Transfer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_SCK_ACTIVE              (0x1a)
/*
   Adapter Unable to service write request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_ADAP_OVERFLOW           (0x1b)
/*
   Adapter Unable to service read request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_ADAP_UNDERFLOW          (0x1c)
/*
   A Read socket has been wrapped up
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_READ_FORCE_END          (0x1d)
/*
   A read socket with burstsize > 0 is switched before 8-byte boundary
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH1_READ_BURST_ERR          (0x1e)
/*
   Socket has gone inactive within a DMA Transfer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_SCK_ACTIVE              (0x22)
/*
   Adapter Unable to service write request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_ADAP_OVERFLOW           (0x23)
/*
   Adapter Unable to service read request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_ADAP_UNDERFLOW          (0x24)
/*
   A Read socket has been wrapped up
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_READ_FORCE_END          (0x25)
/*
   A read socket with burstsize > 0 is switched before 8-byte boundary
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH2_READ_BURST_ERR          (0x26)
/*
   Socket has gone inactive within a DMA Transfer
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_SCK_ACTIVE              (0x2a)
/*
   Adapter Unable to service write request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_ADAP_OVERFLOW           (0x2b)
/*
   Adapter Unable to service read request though buffer is available
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_ADAP_UNDERFLOW          (0x2c)
/*
   A Read socket has been wrapped up
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_READ_FORCE_END          (0x2d)
/*
   A read socket with burstsize > 0 is switched before 8-byte boundary
 */
#define CY_U3P_PIB_PIB_ERR_CODE_TH3_READ_BURST_ERR          (0x2e)

/*
   An unrecoverable error occurred in the PMMC controller. FW clears this
   bit after handling the eror. The error code is indicated in PIB_ERROR.MMC_ERR_CODE
 */
#define CY_U3P_PIB_MMC_ERR_CODE_MASK                        (0x000003c0) /* <6:9> RW:R:0:No */
#define CY_U3P_PIB_MMC_ERR_CODE_POS                         (6)

/*
   When the buffer is not a multiple of block size
 */
#define CY_U3P_PIB_MMC_ERR_CODE_UNDERRUN                    (1)
/*
   When the buffer is not a multiple of block size
 */
#define CY_U3P_PIB_MMC_ERR_CODE_OVERRUN                     (2)
/*
   Addressed socket not ready for a WRITE command 1st block
 */
#define CY_U3P_PIB_MMC_ERR_CODE_DATA_NOT_READY              (3)
/*
   CRC error on block write targetting register space
 */
#define CY_U3P_PIB_MMC_ERR_CODE_REG_DATA_CRC_ERROR          (6)
/*
   CRC error on block write to sockets
 */
#define CY_U3P_PIB_MMC_ERR_CODE_DMA_DATA_CRC_ERROR          (7)

/*
   Error code for the first error code since ERROR=1
   Error codes are specified in detail the USB30PIB BROS.
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_MASK                       (0x00007c00) /* <10:14> RW:R:0:No */
#define CY_U3P_PIB_GPIF_ERR_CODE_POS                        (10)

/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_IN_ADDR_OVER_WRITE         (1)
/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_EG_ADDR_NOT_VALID          (2)
/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_DMA_DATA_RD_ERROR          (3)
/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_DMA_DATA_WR_ERROR          (4)
/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_DMA_ADDR_RD_ERROR          (5)
/*
   Attempt to push to the active address thread which is not dma_ready
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_DMA_ADDR_WR_ERROR          (6)
/*
   received data in serial mode has parity error
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_SERIAL_PARITY_ERROR        (7)
/*
   statemachine has transitioned to an invalid state
 */
#define CY_U3P_PIB_GPIF_ERR_CODE_INVALID_STATE_ERROR        (8)


/*
   PIB EOP/EOT configuration
 */
#define CY_U3P_PIB_EOP_EOT_ADDRESS                          (0xe0010024)
#define CY_U3P_PIB_EOP_EOT                                  (*(uvint32_t *)(0xe0010024))
#define CY_U3P_PIB_EOP_EOT_DEFAULT                          (0x00000001)

/*
   This register specifies how EOP bits are set or interpretted for Ingress
   and Egress sockets respectively.
   1: Packet mode behavior
   0: Stream mode behavior
   See Architecture Spec for details.
 */
#define CY_U3P_PIB_PIB_EOP_EOT_CFG_MASK                     (0xffffffff) /* <0:31> R:RW:1:Yes */
#define CY_U3P_PIB_PIB_EOP_EOT_CFG_POS                      (0)


/*
   Configure the DLL phases and enable it.
 */
#define CY_U3P_PIB_DLL_CTRL_ADDRESS                         (0xe0010028)
#define CY_U3P_PIB_DLL_CTRL                                 (*(uvint32_t *)(0xe0010028))
#define CY_U3P_PIB_DLL_CTRL_DEFAULT                         (0x0000f8f0)

/*
   Drives the DLLEN input
       0: DLL is disabled (internally power gated)
       1: DLL is enabled
 */
#define CY_U3P_PIB_DLL_ENABLE                               (1u << 0) /* <0:0> R:RW:0:No */


/*
   0: 23-80MHz
   1: 70-230MHz
 */
#define CY_U3P_PIB_DLL_HIGH_FREQ                            (1u << 1) /* <1:1> R:RW:0:No */


/*
   0: DLL is not in phase lock.
   1: DLL has achieved phase lock.
 */
#define CY_U3P_PIB_DLL_DLL_STAT                             (1u << 2) /* <2:2> W:R:0:Yes */


/*
   Selects the phase of clock used in GPIF and PMMC core.
 */
#define CY_U3P_PIB_DLL_CORE_PHASE_SELECT_MASK               (0x000000f0) /* <4:7> R:RW:0xF:No */
#define CY_U3P_PIB_DLL_CORE_PHASE_SELECT_POS                (4)


/*
   Selects one of the 16 phase shifted clocks for the input synchronizer
   paths. Used only for Async protocols.
 */
#define CY_U3P_PIB_DLL_SYNC_PHASE_SELECT_MASK               (0x00000f00) /* <8:11> R:RW:0x8:No */
#define CY_U3P_PIB_DLL_SYNC_PHASE_SELECT_POS                (8)


/*
   Selects one of the 16 phase shifted clocks for the output paths for both
   PMMC and Sync/Async GPIF protocols
 */
#define CY_U3P_PIB_DLL_OUTPUT_PHASE_SELECT_MASK             (0x0000f000) /* <12:15> R:RW:0xF:No */
#define CY_U3P_PIB_DLL_OUTPUT_PHASE_SELECT_POS              (12)


/*
   DLL Operation mode for the PIB master DLL. This field is used only for
   DLL characterization. During normal operation the only allowed value for
   this field is "0".
     0: DLL is master mode. The DLL locks to its input clock
     1: DLL is in slave mode. The DLL creates delays based on the values
   specified in DLL_SLAVE_DLY register field
 */
#define CY_U3P_PIB_DLL_DLL_MODE                             (1u << 16) /* <16:16> R:RW:0:No */


/*
   DLL Slave mode delay control - to be used only for characterization in
   conjunction with the DLL_MODE field in this register.
 */
#define CY_U3P_PIB_DLL_DLL_SLAVE_DLY_MASK                   (0x07fe0000) /* <17:26> R:RW:0:No */
#define CY_U3P_PIB_DLL_DLL_SLAVE_DLY_POS                    (17)


/*
   Selects the mode of operation of the DLL per the following. When the DLL
   outputs are selected to be observed in the clock_observation_mode test
   mode, this field can be used to control the DLL's DFT behavior. In normal
   operation mode of the chip, only the "000" setting is allowed.  When the
   DFT modes are selected, the relevant DLL observation signals are available
   for monitoring on the chip outputs as specified in the description of
   the clock_observation_mode.
   000 Normal Operation
   111 Slave mode with user configured delay.
 */
#define CY_U3P_PIB_DLL_DLL_DFT_MODE_MASK                    (0x38000000) /* <27:29> R:RW:0:No */
#define CY_U3P_PIB_DLL_DLL_DFT_MODE_POS                     (27)


/*
   Resets the DLL.
      0:  DLL is reset
      1:  DLL is not reset
 */
#define CY_U3P_PIB_DLL_DLL_RESET_N                          (1u << 30) /* <30:30> R:RW:0:No */


/*
   0 - Hardware does not reset DLL when DLL code overrun/under-run occurs
   1 - Hardware resets DLL when DLL code overrun/under-run occurs
 */
#define CY_U3P_PIB_DLL_ENABLE_RESET_ON_ERR                  (1u << 31) /* <31:31> R:RW:0:No */



/*
   P-Port Device ID Register
 */
#define CY_U3P_PIB_PP_ID_ADDRESS                            (0xe0017e00)
#define CY_U3P_PIB_PP_ID                                    (*(uvint32_t *)(0xe0017e00))
#define CY_U3P_PIB_PP_ID_DEFAULT                            (0x00000000)

/*
   Provides a device ID as defined in IROS.
 */
#define CY_U3P_PIB_DEVICE_ID_MASK                           (0x0000ffff) /* <0:15> RW:R:0:No */
#define CY_U3P_PIB_DEVICE_ID_POS                            (0)



/*
   P-Port reset and power control
 */
#define CY_U3P_PIB_PP_INIT_ADDRESS                          (0xe0017e04)
#define CY_U3P_PIB_PP_INIT                                  (*(uvint32_t *)(0xe0017e04))
#define CY_U3P_PIB_PP_INIT_DEFAULT                          (0x00000c01)

/*
   Indicates system woke up through a power-on-reset or RESET# pin reset
   sequence. If firmware does not clear this bit it will stay 1 even through
   software reset, standby and suspend sequences.  This bit is a shadow bit
   of GCTL_CONTROL.
 */
#define CY_U3P_PIB_POR                                      (1u << 0) /* <0:0> RW:R:1:No */


/*
   Indicates system woke up from a s/w induced hard reset sequence (from
   GCTL_CONTROL.HARD_RESET_N or PP_INIT.HARD_RESET_N).  If firmware does
   not clear this bit it will stay 1 even through standby and suspend sequences.
   This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_PIB_SW_RESET                                 (1u << 1) /* <1:1> RW:R:0:No */


/*
   Indicates system woke up from a watchdog timer induced hard reset (see
   GCTL_WATCHDOG_CS).  If firmware does not clear this bit it will stay 1
   even through standby and suspend sequences. This bit is a shadow bit of
   GCTL_CONTROL.
 */
#define CY_U3P_PIB_WDT_RESET                                (1u << 2) /* <2:2> RW:R:0:No */


/*
   Indicates system woke up from standby mode (see architecture spec for
   details). If firmware does not clear this bit it will stay 1 even through
   suspend sequences. This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_PIB_WAKEUP_PWR                               (1u << 3) /* <3:3> RW:R:0:No */


/*
   Indicates system woke up from suspend state (see architecture spec for
   details). If firmware does not clear this bit it will stay 1 even through
   standby sequences. This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_PIB_WAKEUP_CLK                               (1u << 4) /* <4:4> RW:R:0:No */


/*
   Software clears this bit to effect a CPU reset (aka reboot).  No other
   blocks or registers are affected.  The CPU will enter the boot ROM, that
   will use the WARM_BOOT flag to determine whether to reload firmware.
   Unlike the same bit in GCTL_CONTROL, the software needs to explicitly
   clear and then set this bit to bring the internal CPU out of reset.  It
   is permissible to keep the ARM CPU in reset for an extended period of
   time (although not advisable).
 */
#define CY_U3P_PIB_CPU_RESET_N                              (1u << 10) /* <10:10> RW:R:1:No */


/*
   Software clears this bit to effect a global hard reset (all blocks, all
   flops).  This is equivalent to toggling the RESET pin on the device. 
   This function is also available to internal firmware in GCTL_CONTROL.
 */
#define CY_U3P_PIB_HARD_RESET_N                             (1u << 11) /* <11:11> RW:R:1:No */


/*
   0: P-Port is Little Endian
   1: P-Port is Big Endian
 */
#define CY_U3P_PIB_BIG_ENDIAN                               (1u << 15) /* <15:15> RW:R:0:No */



/*
   P-Port Configuration Register
 */
#define CY_U3P_PIB_PP_CONFIG_ADDRESS                        (0xe0017e08)
#define CY_U3P_PIB_PP_CONFIG                                (*(uvint32_t *)(0xe0017e08))
#define CY_U3P_PIB_PP_CONFIG_DEFAULT                        (0x0000004f)

/*
   Size of DMA bursts; only relevant when DRQMODE=1.
   0-14:  DMA burst size is 2BURSTSIZE words
   15: DMA burst size is infinite (DRQ de-asserts on last cycle of transfer)
 */
#define CY_U3P_PIB_BURSTSIZE_MASK                           (0x0000000f) /* <0:3> RW:R:15:No */
#define CY_U3P_PIB_BURSTSIZE_POS                            (0)


/*
   Initialization Mode
   0: Normal operation mode.
   1: Initialization mode.
   This bit is cleared to 