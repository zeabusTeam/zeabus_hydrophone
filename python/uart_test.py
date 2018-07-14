import serial
import struct
import numpy as np

value = 30000

s = serial.Serial('com4',115200,bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)

res = []
res.append(61)
res.append(61)
res.append(61)
res.append(61)
tmp = struct.pack('I', value)
res.append(tmp[0])
res.append(tmp[1])
res.append(tmp[2])
res.append(tmp[3])
# res.append(tmp[0:2].decode("hex"))
# res.append(tmp[2:4].decode("hex"))
# res.append(tmp[4:6].decode("hex"))
# res.append(tmp[6:8].decode("hex"))
print(res)
s.write(res)
s.flush()
N = 100
sig_re_1 = []
sig_re_2 = []
sig_re_3 = []
sig_re_4 = []
sig_im_1 = []
sig_im_2 = []
sig_im_3 = []
sig_im_4 = []

for i in range(N):
    sig_re_1.append(0.0)
    sig_re_2.append(0.0)
    sig_re_3.append(0.0)
    sig_re_4.append(0.0)
    sig_im_1.append(0.0)
    sig_im_2.append(0.0)
    sig_im_3.append(0.0)
    sig_im_4.append(0.0)

count = 0
while True:
    while True:
        x = s.read(1)
        if x == b'\xff':
            print(x)
            x = s.read(1)
            print(x)
            count +=1
            if x == b'\xff':
                x = s.read(14)
                # print(x)
                count = 0
                break

            
    seq = struct.unpack('<H', x[0:2])
    freq = struct.unpack('<I', x[2:6])
    time_between_pulse = struct.unpack('<I', x[6:10])
    processing_time = struct.unpack('<I', x[10:14])

    print ("seq : %d" %seq)
    print ("freq : %d" %freq)
    print ("time_between_pulse : %d" %time_between_pulse)
    print ("processing_time : %d" %processing_time)

    x = s.read(1)
    x = s.read(1)
 

    x = s.read(1600)

    start_id = 0

    a = start_id
    for i in range(0, 100):
        sig_re_1[i] = struct.unpack('@f', x[(a + (i * 4)) :(a + (i * 4) + 4)])
        start_id = start_id + 4
    
    a = start_id
    for i in range(0, 100):
        sig_re_2[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4

    a = start_id
    for i in range(0, 100):
        sig_re_3[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4

    a = start_id
    for i in range(0, 100):
        sig_re_4[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4

    x = s.read(1)
    x = s.read(1)

    x = s.read(1600)
    start_id = 0
    a = start_id
    for i in range(0, 100):
        sig_im_1[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4
    
    a = start_id
    for i in range(0, 100):
        sig_im_2[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4
    
    a = start_id
    for i in range(0, 100):
        sig_im_3[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4

    a = start_id
    for i in range(0, 100):
        sig_im_4[i] = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
        start_id = start_id + 4

    x = s.read(1)
    x = s.read(1)

    print(sig_re_1)

