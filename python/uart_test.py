import serial
import struct

value = 30000

s = serial.Serial('com3',115200,bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)

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
                x = s.read(8)
                print(x)
                count = 0
                break

            
    seq = struct.unpack('<H', x[0:2])
    freq = struct.unpack('<I', x[2:6])

    print ("seq : %d" %seq)
    print ("freq : %d" %freq)


