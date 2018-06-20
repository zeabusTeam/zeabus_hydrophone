/**
  ******************************************************************************
  * File Name          : mdma.c
  * Description        : This file provides code for the configuration
  *                      of all the requested global MDMA transfers.
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "mdma.h"

/* USER CODE BEGIN 0 */
#include "common.h"

/* USER CODE END 0 */

/*----------------------------------------------------------------------------*/
/* Configure MDMA                                                              */
/*----------------------------------------------------------------------------*/

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
MDMA_HandleTypeDef hmdma_mdma_channel0_sw_0;
MDMA_HandleTypeDef hmdma_mdma_channel1_sw_0;
MDMA_HandleTypeDef hmdma_mdma_channel2_sw_0;
MDMA_HandleTypeDef hmdma_mdma_channel3_sw_0;

/** 
  * Enable MDMA controller clock
  * Configure MDMA for global transfers
  *   hmdma_mdma_channel0_sw_0
  *   hmdma_mdma_channel1_sw_0
  *   hmdma_mdma_channel2_sw_0
  *   hmdma_mdma_channel3_sw_0
  */
void MX_MDMA_Init(void) 
{
  /* MDMA controller clock enable */
  __HAL_RCC_MDMA_CLK_ENABLE();
  /* Local variables */

  /* Configure MDMA channel MDMA_Channel0 */
  /* Configure MDMA request hmdma_mdma_channel0_sw_0 on MDMA_Channel0 */
  hmdma_mdma_channel0_sw_0.Instance = MDMA_Channel0;
  hmdma_mdma_channel0_sw_0.Init.Request = MDMA_REQUEST_SW;
  hmdma_mdma_channel0_sw_0.Init.TransferTriggerMode = MDMA_FULL_TRANSFER;
  hmdma_mdma_channel0_sw_0.Init.Priority = MDMA_PRIORITY_HIGH;
  hmdma_mdma_channel0_sw_0.Init.Endianness = MDMA_LITTLE_ENDIANNESS_PRESERVE;
  hmdma_mdma_channel0_sw_0.Init.SourceInc = MDMA_SRC_INC_DOUBLEWORD;
  hmdma_mdma_channel0_sw_0.Init.DestinationInc = MDMA_DEST_INC_WORD;
  hmdma_mdma_channel0_sw_0.Init.SourceDataSize = MDMA_SRC_DATASIZE_WORD;
  hmdma_mdma_channel0_sw_0.Init.DestDataSize = MDMA_DEST_DATASIZE_WORD;
  hmdma_mdma_channel0_sw_0.Init.DataAlignment = MDMA_DATAALIGN_PACKENABLE;
  hmdma_mdma_channel0_sw_0.Init.BufferTransferLength = 128;
  hmdma_mdma_channel0_sw_0.Init.SourceBurst = MDMA_SOURCE_BURST_SINGLE;
  hmdma_mdma_channel0_sw_0.Init.DestBurst = MDMA_DEST_BURST_SINGLE;
  hmdma_mdma_channel0_sw_0.Init.SourceBlockAddressOffset = 0;
  hmdma_mdma_channel0_sw_0.Init.DestBlockAddressOffset = 0;
  if (HAL_MDMA_Init(&hmdma_mdma_channel0_sw_0) != HAL_OK)
  {
    Error_Handler();
  }

  /* Configure MDMA channel MDMA_Channel1 */
  /* Configure MDMA request hmdma_mdma_channel1_sw_0 on MDMA_Channel1 */
  hmdma_mdma_channel1_sw_0.Instance = MDMA_Channel1;
  hmdma_mdma_channel1_sw_0.Init.Request = MDMA_REQUEST_SW;
  hmdma_mdma_channel1_sw_0.Init.TransferTriggerMode = MDMA_FULL_TRANSFER;
  hmdma_mdma_channel1_sw_0.Init.Priority = MDMA_PRIORITY_HIGH;
  hmdma_mdma_channel1_sw_0.Init.Endianness = MDMA_LITTLE_ENDIANNESS_PRESERVE;
  hmdma_mdma_channel1_sw_0.Init.SourceInc = MDMA_SRC_INC_DOUBLEWORD;
  hmdma_mdma_channel1_sw_0.Init.DestinationInc = MDMA_DEST_INC_WORD;
  hmdma_mdma_channel1_sw_0.Init.SourceDataSize = MDMA_SRC_DATASIZE_WORD;
  hmdma_mdma_channel1_sw_0.Init.DestDataSize = MDMA_DEST_DATASIZE_WORD;
  hmdma_mdma_channel1_sw_0.Init.DataAlignment = MDMA_DATAALIGN_PACKENABLE;
  hmdma_mdma_channel1_sw_0.Init.BufferTransferLength = 128;
  hmdma_mdma_channel1_sw_0.Init.SourceBurst = MDMA_SOURCE_BURST_SINGLE;
  hmdma_mdma_channel1_sw_0.Init.DestBurst = MDMA_DEST_BURST_SINGLE;
  hmdma_mdma_channel1_sw_0.Init.SourceBlockAddressOffset = 0;
  hmdma_mdma_channel1_sw_0.Init.DestBlockAddressOffset = 0;
  if (HAL_MDMA_Init(&hmdma_mdma_channel1_sw_0) != HAL_OK)
  {
    Error_Handler();
  }

  /* Configure MDMA channel MDMA_Channel2 */
  /* Configure MDMA request hmdma_mdma_channel2_sw_0 on MDMA_Channel2 */
  hmdma_mdma_channel2_sw_0.Instance = MDMA_Channel2;
  hmdma_mdma_channel2_sw_0.Init.Request = MDMA_REQUEST_SW;
  hmdma_mdma_channel2_sw_0.Init.TransferTriggerMode = MDMA_FULL_TRANSFER;
  hmdma_mdma_channel2_sw_0.Init.Priority = MDMA_PRIORITY_HIGH;
  hmdma_mdma_channel2_sw_0.Init.Endianness = MDMA_LITTLE_ENDIANNESS_PRESERVE;
  hmdma_mdma_channel2_sw_0.Init.SourceInc = MDMA_SRC_INC_DOUBLEWORD;
  hmdma_mdma_channel2_sw_0.Init.DestinationInc = MDMA_DEST_INC_WORD;
  hmdma_mdma_channel2_sw_0.Init.SourceDataSize = MDMA_SRC_DATASIZE_WORD;
  hmdma_mdma_channel2_sw_0.Init.DestDataSize = MDMA_DEST_DATASIZE_WORD;
  hmdma_mdma_channel2_sw_0.Init.DataAlignment = MDMA_DATAALIGN_PACKENABLE;
  hmdma_mdma_channel2_sw_0.Init.BufferTransferLength = 128;
  hmdma_mdma_channel2_sw_0.Init.SourceBurst = MDMA_SOURCE_BURST_SINGLE;
  hmdma_mdma_channel2_sw_0.Init.DestBurst = MDMA_DEST_BURST_SINGLE;
  hmdma_mdma_channel2_sw_0.Init.SourceBlockAddressOffset = 0;
  hmdma_mdma_channel2_sw_0.Init.DestBlockAddressOffset = 0;
  if (HAL_MDMA_Init(&hmdma_mdma_channel2_sw_0) != HAL_OK)
  {
    Error_Handler();
  }

  /* Configure MDMA channel MDMA_Channel3 */
  /* Configure MDMA request hmdma_mdma_channel3_sw_0 on MDMA_Channel3 */
  hmdma_mdma_channel3_sw_0.Instance = MDMA_Channel3;
  hmdma_mdma_channel3_sw_0.Init.Request = MDMA_REQUEST_SW;
  hmdma_mdma_channel3_sw_0.Init.TransferTriggerMode = MDMA_FULL_TRANSFER;
  hmdma_mdma_channel3_sw_0.Init.Priority = MDMA_PRIORITY_HIGH;
  hmdma_mdma_channel3_sw_0.Init.Endianness = MDMA_LITTLE_ENDIANNESS_PRESERVE;
  hmdma_mdma_channel3_sw_0.Init.SourceInc = MDMA_SRC_INC_DOUBLEWORD;
  hmdma_mdma_channel3_sw_0.Init.DestinationInc = MDMA_DEST_INC_WORD;
  hmdma_mdma_channel3_sw_0.Init.SourceDataSize = MDMA_SRC_DATASIZE_WORD;
  hmdma_mdma_channel3_sw_0.Init.DestDataSize = MDMA_DEST_DATASIZE_WORD;
  hmdma_mdma_channel3_sw_0.Init.DataAlignment = MDMA_DATAALIGN_PACKENABLE;
  hmdma_mdma_channel3_sw_0.Init.BufferTransferLength = 128;
  hmdma_mdma_channel3_sw_0.Init.SourceBurst = MDMA_SOURCE_BURST_SINGLE;
  hmdma_mdma_channel3_sw_0.Init.DestBurst = MDMA_DEST_BURST_SINGLE;
  hmdma_mdma_channel3_sw_0.Init.SourceBlockAddressOffset = 0;
  hmdma_mdma_channel3_sw_0.Init.DestBlockAddressOffset = 0;
  if (HAL_MDMA_Init(&hmdma_mdma_channel3_sw_0) != HAL_OK)
  {
    Error_Handler();
  }

}
/* USER CODE BEGIN 2 */
/* USER CODE END 2 */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
