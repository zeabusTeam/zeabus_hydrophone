import serial
import struct
import numpy as np

def open_serial_port(port):
    s = serial.Serial('/dev/cu.usbmodem14103', 460800, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE,
                           stopbits=serial.STOPBITS_ONE)
    return s

def get_pulse_data(s):
    # Length of each signal stream (fixed)
    n = 2048

    # Seeking for the beginning sequence, "\xFF\xFF", then reading 14-byte header
    while True:
        x = s.read(1)
        if x == b'\xFF':
            x = s.read(1)
            count += 1
            if x == b'\xFF':
                x = s.read(14)
                break

    # Prepare data structures

    sig = np.zeros( shape=( 4, n ), type=np.float32 )

    # Process header (little endian)
    # Sequence number is the first 2 bytes
    seq = struct.unpack('<H', x[0:2])
    # 4-byte unsigned int for Frequency 
    freq = struct.unpack('<I', x[2:6])
    # 4-byte unsigned int for time between pulse
    time_between_pulse = struct.unpack('<I', x[6:10])
    # 4-byte unsigned int for processing time
    processing_time = struct.unpack('<I', x[10:14])

    print("seq : %d" % seq)
    print("freq : %d" % freq)
    print("time_between_pulse : %d" % time_between_pulse)
    print("processing_time : %d" % processing_time)

    # Data arrives in sequence of 2 streams. Each seqence is leaded by 2 bytes of sync.
    # We have 4 hydrophones; therefore, a set of data must have 2 seqences.
    # Another extra empty sequence must be appended as the closing seqence.

    # The first sequence
    # The first 2 bytes of data are sync ('\x11\x11')
    x = s.read(1)
    x = s.read(1)

    # Reading and processing the first sequence (2 streams of 4-byte data)
    x = s.read(n * 4 * 2)

    start_sig2 = n * 4

    # Extract 2 sound streams. Each consists of a series of 4-byte floating-point data
    for i in range(0, n):
        (sig[0, i],) = struct.unpack('@f', x[ (i * 4) : ((i * 4) + 4) ] )
        (sig[1, i],) = struct.unpack('@f', x[ (start_sig2 + (i * 4)) : (start_sig2 + (i * 4) + 4 )] )

    # The sencond sequence
    # The first 2 bytes of data are sync ('\x22\x22')
    x = s.read(1)
    x = s.read(1)

    x = s.read(n * 4 * 2)

    # Extract 2 sound streams. Each consists of a series of 4-byte floating-point data
    for i in range(0, n):
        (sig[0, i],) = struct.unpack('@f', x[ (i * 4) : ((i * 4) + 4) ] )
        (sig[1, i],) = struct.unpack('@f', x[ (start_sig2 + (i * 4)) : (start_sig2 + (i * 4) + 4 )] )

    # The third sequence (the empty sequence indicating end of data)
    # The first 2 bytes of data are sync ('\x33\x33')
    x = s.read(1)
    x = s.read(1)

    return sig

def sent_dsp_param(s, Frequency, SoundSpeed, FrontThreshold, PowerThreshold, DelayObserve, LNA_Gain):
    res = []
    res.append(61)
    res.append(61)
    res.append(61)
    res.append(61)
    tmp = struct.pack('I', Frequency)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('I', SoundSpeed)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('f', FrontThreshold)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('f', PowerThreshold)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('I', DelayObserve)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('f', LNA_Gain)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])

    s.write(res)
    s.flush()
