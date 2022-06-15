import numpy as np
from matplotlib import pyplot as plt

filename = 'data.hex'

hydrophone1 = np.loadtxt(filename, dtype='int16', converters={0:lambda s:int(s[0:4],16)})
hydrophone2 = np.loadtxt(filename, dtype='int16', converters={0:lambda s:int(s[4:8],16)})
hydrophone3 = np.loadtxt(filename, dtype='int16', converters={0:lambda s:int(s[8:12],16)})
hydrophone4 = np.loadtxt(filename, dtype='int16', converters={0:lambda s:int(s[12:16],16)})

# Ploting
fig, sub = plt.subplots(2,2)

sub[0, 0].plot(hydrophone1)
sub[0, 0].set_title('Channel 1')
sub[0, 1].plot(hydrophone2)
sub[0, 1].set_title('Channel 2')
sub[1, 0].plot(hydrophone3)
sub[1, 0].set_title('Channel 3')
sub[1, 1].plot(hydrophone4)
sub[1, 1].set_title('Channel 4')

plt.show()
