import numpy as np
from matplotlib import pyplot as plt

# Main part
if __name__ == '__main__':
    data = np.loadtxt( open('hp_output.hex','rb'), delimiter=',', dtype='int16', converters={1:lambda d:int(d,16), 2:lambda s:int(s,16)} )
    data_t = np.transpose( data )

    fig, ax = plt.subplots()

    plt.subplot(2,2,1)
    data1, = plt.plot(data_t[1])
    plt.title('Gaussian')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.subplot(2,2,2)
    data2, = plt.plot(data_t[2])
    plt.title('Median')
    plt.xlabel('Sample')
    plt.ylabel('Norm. Amplitude')
    plt.grid(True)

    plt.tight_layout()
    plt.subplots_adjust(bottom=0.22)

    plt.show()
