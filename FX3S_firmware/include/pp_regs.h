/*
 ## Cypress FX3 Core Library Header (pp_regs.h)
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

#ifndef _INCLUDED_P_PORT_H_
#define _INCLUDED_P_PORT_H_

/*
   P-Port Device ID Register
 */
#define CY_U3P_PP_ID_ADDRESS                                (0x00000080)
#define CY_U3P_PP_ID                                        (*(uvint32_t *)(0x00000080))
#define CY_U3P_PP_ID_DEFAULT                                (0x00000000)

/*
   Provides a device ID as defined in IROS.
 */
#define CY_U3P_DEVICE_ID_MASK                               (0x0000ffff) /* <0:15> RW:R:0:No */
#define CY_U3P_DEVICE_ID_POS                                (0)



/*
   P-Port reset and power control
 */
#define CY_U3P_PP_INIT_ADDRESS                              (0x00000081)
#define CY_U3P_PP_INIT                                      (*(uvint32_t *)(0x00000081))
#define CY_U3P_PP_INIT_DEFAULT                              (0x00000c01)

/*
   Indicates system woke up through a power-on-reset or RESET# pin reset
   sequence. If firmware does not clear this bit it will stay 1 even through
   software reset, standby and suspend sequences.  This bit is a shadow bit
   of GCTL_CONTROL.
 */
#define CY_U3P_POR                                          (1u << 0) /* <0:0> RW:R:1:No */


/*
   Indicates system woke up from a s/w induced hard reset sequence (from
   GCTL_CONTROL.HARD_RESET_N or PP_INIT.HARD_RESET_N).  If firmware does
   not clear this bit it will stay 1 even through standby and suspend sequences.
   This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_SW_RESET                                     (1u << 1) /* <1:1> RW:R:0:No */


/*
   Indicates system woke up from a watchdog timer induced hard reset (see
   GCTL_WATCHDOG_CS).  If firmware does not clear this bit it will stay 1
   even through standby and suspend sequences. This bit is a shadow bit of
   GCTL_CONTROL.
 */
#define CY_U3P_WDT_RESET                                    (1u << 2) /* <2:2> RW:R:0:No */


/*
   Indicates system woke up from standby mode (see architecture spec for
   details). If firmware does not clear this bit it will stay 1 even through
   suspend sequences. This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_WAKEUP_PWR                                   (1u << 3) /* <3:3> RW:R:0:No */


/*
   Indicates system woke up from suspend state (see architecture spec for
   details). If firmware does not clear this bit it will stay 1 even through
   standby sequences. This bit is a shadow bit of GCTL_CONTROL.
 */
#define CY_U3P_WAKEUP_CLK                                   (1u << 4) /* <4:4> RW:R:0:No */


/*
   Software clears this bit to effect a CPU reset (aka reboot).  No other
   blocks or registers are affected.  The CPU will enter the boot ROM, that
   will use the WARM_BOOT flag to determine whether to reload firmware.
   Unlike the same bit in GCTL_CONTROL, the software needs to explicitly
   clear and then set this bit to bring the internal CPU out of reset.  It
   is permissible to keep the ARM CPU in reset for an extended period of
   time (although not advisable).
 */
#define CY_U3P_CPU_RESET_N                                  (1u << 10) /* <10:10> R:RW:1:No */


/*
   Software clears this bit to effect a global hard reset (all blocks, all
   flops).  This is equivalent to toggling the RESET pin on the device. 
   This function is also available to internal firmware in GCTL_CONTROL.
 */
#define CY_U3P_HARD_RESET_N                                 (1u << 11) /* <11:11> R:RW0C:1:No */


/*
   0: P-Port is Little Endian
   1: P-Port is Big Endian
 */
#define CY_U3P_BIG_ENDIAN                                   (1u << 15) /* <15:15> R:RW:0:No */



/*
   P-Port Configuration Register
 */
#define CY_U3P_PP_CONFIG_ADDRESS                            (0x00000082)
#define CY_U3P_PP_CONFIG                                    (*(uvint32_t *)(0x00000082))
#define CY_U3P_PP_CONFIG_DEFAULT                            (0x0000004f)

/*
   Size of DMA bursts; only relevant when DRQMODE=1.
   0-14:  DMA burst size is 2BURSTSIZE words
   15: DMA burst size is infinite (DRQ de-asserts on last cycle of transfer)
 */
#define CY_U3P_BURSTSIZE_MASK                               (0x0000000f) /* <0:3> R:RW:15:No */
#define CY_U3P_BURSTSIZE_POS                                (0)


/*
   Initialization Mode
   0: Normal operation mode.
   1: Initialization mode.
   This bit is cleared to 