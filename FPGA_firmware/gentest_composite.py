import numpy as np
from matplotlib import pyplot as plt

fs = 64000000    # Sampling frequency
f = 25000       # Frequency of the pinger
strength = 32000    # Signal strength
period = 0.001   # Period of the signal activity (1 ms)
pre_silent1 = 0.0003 # Silent period before signal of hydrophone 1
pre_silent2 = 0.00031 # Silent period before signal of hydrophone 2
pre_silent3 = 0.00031 # Silent period before signal of hydrophone 3
pre_silent4 = 0.00033 # Silent period before signal of hydrophone 4

# Silent period of each channel after signal. Channel 1 is the master. all others are calculate from channel 1 to make array length same
post_silent1 = 0.0003 # Silent period after signal of hydrophone 1

# Leading elements
pre_element1 = np.int(pre_silent1 * fs)
pre_element2 = np.int(pre_silent2 * fs)
pre_element3 = np.int(pre_silent3 * fs)
pre_element4 = np.int(pre_silent4 * fs)

# Post-signal
post_element1 = np.int(post_silent1 * fs)
total_element1 = pre_element1 + post_element1
post_element2 = total_element1 - pre_element2 # Silent period after signal of hydrophone 2
post_element3 = total_element1 - pre_element3 # Silent period after signal of hydrophone 3
post_element4 = total_element1 - pre_element4 # Silent period after signal of hydrophone 4

# Generate time axis
t = np.linspace(0, period, np.int(fs * period))
# Generate signal
y = np.sin(f * 2 * np.pi * t)
# Generate noise
n = np.random.normal(0, 0.7, size=(t.size + total_element1) ) * 511

# Pure signal
s1 = np.concatenate( ( np.zeros(pre_element1), y, np.zeros(post_element1) ) ) * strength
s2 = np.concatenate( ( np.zeros(pre_element2), y, np.zeros(post_element2) ) ) * strength
s3 = np.concatenate( ( np.zeros(pre_element3), y, np.zeros(post_element3) ) ) * strength
s4 = np.concatenate( ( np.zeros(pre_element4), y, np.zeros(post_element4) ) ) * strength

# Signal + noise
s1 = s1 + n
s2 = s2 + n
s3 = s3 + n
s4 = s4 + n

# convert to int16
s1 = np.uint16(np.int16(s1))
s2 = np.uint16(np.int16(s2))
s3 = np.uint16(np.int16(s3))
s4 = np.uint16(np.int16(s4))

for i in range(s1.size):
    print("%04X%04X%04X%04X"%(s1[i],s2[i],s3[i],s4[i]))

