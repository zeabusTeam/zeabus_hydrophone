/*
 ## Cypress FX3 Core Library Header (sock_regs.h)
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

#ifndef _INCLUDED_SOCK_REGS_H_
#define _INCLUDED_SOCK_REGS_H_

#include <cyu3types.h>

/*
   This file contains the definitions for all of the DMA socket and descriptor registers
   on the FX3 device. The information is in this file should be used in conjunction with
   the structure definitions in cyu3socket.h and cyu3descriptor.h
 */

/*###########################################################################
  ####################### Socket Register Definitions #######################
  ###########################################################################*/

/*
   The following definitions correspond to the registers that make up the
   CyU3PDmaSocket_t structure.
 */

/*
   ############################################################################
   dscrChain Register definition.
   ############################################################################
 */

/*
   Descriptor number of currently active descriptor.  A value of 0xFFFF designates
   no (more) active descriptors available.  When activating a socket CPU
   shall write number of first descriptor in here. Only modify this field
   when go_suspend=1 or go_enable=0
 */
#define CY_U3P_DSCR_NUMBER_MASK                             (0x0000ffff) /* <0:15> RW:RW:X:N/A */
#define CY_U3P_DSCR_NUMBER_POS                              (0)


/*
   Number of descriptors still left to process.  This value is unrelated
   to actual number of descriptors in the list.  It is used only to generate
   an interrupt to the CPU when the value goes low or zero (or both).  When
   this value reaches 0 it will wrap around to 255.  The socket will not
   suspend or be otherwise affected unless the descriptor chains ends with
   0xFFFF descriptor number.
 */
#define CY_U3P_DSCR_COUNT_MASK                              (0x00ff0000) /* <16:23> RW:RW:X:N/A */
#define CY_U3P_DSCR_COUNT_POS                               (16)


/*
   The low watermark for dscr_count.  When dscr_count is equal or less than
   dscr_low the status bit dscr_is_low is set and an interrupt can be generated
   (depending on int mask).
 */
#define CY_U3P_DSCR_LOW_MASK                                (0xff000000) /* <24:31> R:RW:X:N/A */
#define CY_U3P_DSCR_LOW_POS                                 (24)

/*
   ############################################################################
   xferSize Register definition.
   ############################################################################
 */

/*
   The number of bytes or buffers (depends on unit bit in SCK_STATUS) that
   are part of this transfer.  A value of 0 signals an infinite/undetermined
   transaction size.
   Valid data bytes remaining in the last buffer beyond the transfer size
   will be read by socket and passed on to the core. FW must ensure that
   no additional bytes beyond the transfer size are present in the last buffer.
 */
#define CY_U3P_TRANS_SIZE_MASK                              (0xffffffff) /* <0:31> R:RW:X:N/A */
#define CY_U3P_TRANS_SIZE_POS                               (0)

/*
   ############################################################################
   xferCount Register definition.
   ############################################################################
 */

/*
   The number of bytes or buffers (depends on unit bit in SCK_STATUS) that
   have been transferred through this socket so far.  If trans_size is >0
   and trans_count>=trans_size the  