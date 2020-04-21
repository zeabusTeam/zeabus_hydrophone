import numpy as np
import matplotlib.pyplot as plt
import sys

# Main part
if __name__ == '__main__':
    MinSample = 0
    MaxSample = 10
    if len( sys.argv ) == 3:
        MinSample = int(sys.argv[1])
        MaxSample = int(sys.argv[2])
    else:
        if len( sys.argv ) == 2:
            MaxSample = int(sys.argv[1])
    
    # Current endian is "big endian"
    raw = np.fromfile( 'data.bin', dtype='>i2' )
    raw = raw[8:]
    
    # All data are in Q13.2 format
    sig1 = raw[0::4]
    sig2 = raw[1::4]
    sig3 = raw[2::4]
    sig4 = raw[3::4]

    #allsig = np.array(( sig1, sig2, sig3, sig4 ))

    print( allsig )
    print( len(sig1) )
    print( hex(sig1[0]), ' ' , hex(sig2[0]))

    fig, ax = plt.subplots()

    plt.subplot(2,2,1)
    data1, = plt.plot(sig1[MinSample:MaxSample])
    plt.title('Hydrophone 1')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.subplot(2,2,2)
    data2, = plt.plot(sig2[MinSample:MaxSample])
    plt.title('Hydrophone 2')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.subplot(2,2,3)
    data3, = plt.plot(sig3[MinSample:MaxSample])
    plt.title('Hydrophone 3')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.subplot(2,2,4)
    data4, = plt.plot(sig4[MinSample:MaxSample])
    plt.title('Hydrophone 4')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.tight_layout()
    plt.subplots_adjust(bottom=0.22)

    plt.show()
