
                        CYPRESS SEMICONDUCTOR CORPORATION
                                    FX3 SDK

SYNCHRONOUS SLAVE FIFO PROTOCOL EXAMPLE
---------------------------------------

  Note: 
  1. There are four binaries available with the zip file.
	a. "SF_StreamIN.img" is generated after enabling the macro "STREAM_IN_OUT" 
  	   and disabling the macro "LOOPBACK_SHRT_ZLP".
	b. "SF_StreamOUT.img" is generated after enabling the macro "STREAM_IN_OUT" 
  	   and disabling the macro "LOOPBACK_SHRT_ZLP".
  	c. "SF_shrt_ZLP.img" is generated after enabling the macro "LOOPBACK_SHRT_ZLP" 
           and disabling the macro "STREAM_IN_OUT". 
  	d. "SF_loopback.img" is generated after enabling the macro "LOOPBACK_SHRT_ZLP" 
           and disabling the macro "STREAM_IN_OUT". 
     Refer to the appnote section "Associated Project Files" for the more details.

  2. This example illustrates the configuration and usage of the GPIF II
     interface on the FX3 device to implement the synchronous slave FIFO
     protocol.

  3. A master device that implements the Cypress defined Sync Slave FIFO
     protocol is required to perform data transfers with this application.

  4. Known limitation:
     In synchronous burst access operation, the minimum transfer size to 
     perform data read/write accesses from/to the FX3 device should be three words.
     In 16-bit mode this is six bytes and 32-bit mode this is twelve bytes.
     To transfer data less than this, single cycle access operation needs to 
     be used.

  5. For loopback transfers, keep the data size as a multiple of 1024 in USB3 or 512 in USB2. 
[]

