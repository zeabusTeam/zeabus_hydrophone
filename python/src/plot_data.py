import numpy as np
import matplotlib.pyplot as plt
import sys

# Main part
if __name__ == '__main__':
    MinSample = 0
    # Current endian is "big endian"
    raw = np.fromfile( 'data.bin', dtype='<i2' )
    #raw = raw[8:]
    
    # All data are in Q13.2 format
    sig1 = raw[0::4]
    sig2 = raw[1::4]
    sig3 = raw[2::4]
    sig4 = raw[3::4]

    # Set the maximum amount of data to plot
    MaxSample = np.amin([len(sig1), len(sig2), len(sig3), len(sig4)])
    if len( sys.argv ) == 3:
        MinSample = int(sys.argv[1])
        MaxSample = int(sys.argv[2])
    else:
        if len( sys.argv ) == 2:
            MaxSample = int(sys.argv[1])
    
    #allsig = np.array(( sig1, sig2, sig3, sig4 ))

    #print( allsig )
    print(f'Total sampling of each hydrophone are {len(sig1)}, {len(sig2)}, {len(sig3)}, {len(sig4)}')

    fig, sub = plt.subplots(2,2)

    sub[0, 0].plot(sig1[MinSample:MaxSample])
    sub[0, 0].set_title('Channel 1')
    sub[0, 0].set_xlabel('Sample')
    sub[0, 0].set_ylabel('Amplitude')
    sub[0, 0].grid(True)
    sub[0, 1].plot(sig2[MinSample:MaxSample])
    sub[0, 1].set_title('Channel 2')
    sub[0, 1].set_xlabel('Sample')
    sub[0, 1].set_ylabel('Amplitude')
    sub[0, 1].grid(True)
    sub[1, 0].plot(sig3[MinSample:MaxSample])
    sub[1, 0].set_title('Channel 3')
    sub[1, 0].set_xlabel('Sample')
    sub[1, 0].set_ylabel('Amplitude')
    sub[1, 0].grid(True)
    sub[1, 1].plot(sig4[MinSample:MaxSample])
    sub[1, 1].set_title('Channel 4')
    sub[1, 1].set_xlabel('Sample')
    sub[1, 1].set_ylabel('Amplitude')
    sub[1, 1].grid(True)

    plt.tight_layout()
    plt.subplots_adjust(bottom=0.22)

    plt.show()
