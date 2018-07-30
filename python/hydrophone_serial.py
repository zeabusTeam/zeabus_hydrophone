import serial
import struct
import numpy as np

def open_serial_port():
    s = serial.Serial('com4', 460800, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE,
                           stopbits=serial.STOPBITS_ONE)
    return s

def get_pulse_data(s):
    n = 2048
    uart_sum = 0;
    count = 0

    while True:
        x = s.read(1)
        uart_sum += 1
        if x == b'\xff':
            # print(x)
            x = s.read(1)
            uart_sum += 1
            # print(x)
            count += 1
            if x == b'\xff':
                x = s.read(14)
                uart_sum += 14
                # print(x)
                count = 0
                break

    array = np.arange(n * 4).reshape(4, n)
    sig = np.zeros_like(array, np.float32)
    seq = struct.unpack('<H', x[0:2])
    freq = struct.unpack('<I', x[2:6])
    time_between_pulse = struct.unpack('<I', x[6:10])
    processing_time = struct.unpack('<I', x[10:14])

    print("seq : %d" % seq)
    print("freq : %d" % freq)
    print("time_between_pulse : %d" % time_between_pulse)
    print("processing_time : %d" % processing_time)

    x = s.read(1)
    x = s.read(1)
    uart_sum += 2

    x = s.read(n * 4 * 2)
    uart_sum += (n * 4 * 2)

    start_id = 0

    a = start_id
    for i in range(0, n):
        (sig[0, i],) = struct.unpack('@f', x[(a + (i * 4)):(a + (i * 4) + 4)])
        start_id = start_id + 4

    a = start_id
    for i in range(0, n):
        (sig[1, i],) = struct.unpack('@f', x[a + (i * 4):a + (i * 4) + 4])
        start_id = start_id + 4

    x = s.read(1)
    x = s.read(1)
    uart_sum += 2

    x = s.read(n * 4 * 2)
    uart_sum += (n * 4 * 2)

    start_id = 0

    a = start_id
    for i in range(0, n):
        (sig[2, i],) = struct.unpack('@f', x[a + (i * 4):a + (i * 4) + 4])
        start_id = start_id + 4

    a = start_id
    for i in range(0, n):
        (sig[3, i],) = struct.unpack('@f', x[a + (i * 4):a + (i * 4) + 4])
        start_id = start_id + 4

    x = s.read(1)
    x = s.read(1)
    uart_sum += 2

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