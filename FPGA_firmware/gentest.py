import numpy as np
from matplotlib import pyplot as plt

fs = 1000000    # Sampling frequency
f = 25000       # Frequency of the pinger
period = 0.004   # Period of the signal activity (4 ms)
pre_silent1 = 0.003 # Silent period before signal of hydrophone 1
pre_silent2 = 0.0031 # Silent period before signal of hydrophone 2
pre_silent3 = 0.0031 # Silent period before signal of hydrophone 3
pre_silent4 = 0.0033 # Silent period before signal of hydrophone 4

# Silent period of each channel after signal. Channel 1 is the master. all others are calculate from channel 1 to make array length same
post_silent1 = 0.003 # Silent period after signal of hydrophone 1
total1 = pre_silent1 + post_silent1
post_silent2 = total1 -  pre_silent2 # Silent period after signal of hydrophone 2
post_silent3 = total1 -  pre_silent3 # Silent period after signal of hydrophone 3
post_silent4 = total1 -  pre_silent4 # Silent period after signal of hydrophone 4

# Generate time axis
t = np.linspace(0, period, fs * period)
# Generate signal
y = np.sin(f * 2 * np.pi * t)


# Final signal
s1 = np.concatenate( ( np.zeros(np.int(pre_silent1 * fs)), y, np.zeros(np.int(post_silent1 * fs)) ) ) * 32767
s2 = np.concatenate( ( np.zeros(np.int(pre_silent2 * fs)), y, np.zeros(np.int(post_silent2 * fs)) ) ) * 32767
s3 = np.concatenate( ( np.zeros(np.int(pre_silent3 * fs)), y, np.zeros(np.int(post_silent3 * fs)) ) ) * 32767
s4 = np.concatenate( ( np.zeros(np.int(pre_silent4 * fs)), y, np.zeros(np.int(post_silent4 * fs)) ) ) * 32767

# convert to int16
s1 = np.uint16(np.int16(s1))
s2 = np.uint16(np.int16(s2))
s3 = np.uint16(np.int16(s3))
s4 = np.uint16(np.int16(s4))

for i in range(s1.size):
    print("%04X%04X%04X%04X"%(s1[i],s2[i],s3[i],s4[i]))

