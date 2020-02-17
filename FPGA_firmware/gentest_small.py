import numpy as np
from matplotlib import pyplot as plt

signal_strength = 32000 # Signal strength
noise_strength = 512 # Noise strength
totalstep = 10000   # Overall steps of data
signalstep = 3000   # Total steps that contain sine signal
signalcycle = 3     # Total desired sine cycles
pre_silent1 = 1000 # Silent period before signal of hydrophone 1
pre_silent2 = 1020 # Silent period before signal of hydrophone 2
pre_silent3 = 1020 # Silent period before signal of hydrophone 3
pre_silent4 = 1050 # Silent period before signal of hydrophone 4
post_silent1 = totalstep - pre_silent1 - signalstep # Silent period after signal of hydrophone 1
post_silent2 = totalstep - pre_silent2 - signalstep # Silent period after signal of hydrophone 2
post_silent3 = totalstep - pre_silent3 - signalstep # Silent period after signal of hydrophone 3
post_silent4 = totalstep - pre_silent4 - signalstep # Silent period after signal of hydrophone 4

# Generate sine wave
t = np.linspace(0, signalstep, signalstep)
s = np.sin( (signalcycle / signalstep) * 2 * np.pi * t)

# Generate noise
n = np.random.normal(0, 0.7, size=totalstep ) * noise_strength

# Generate pure signal
s1 = np.concatenate( ( np.zeros(pre_silent1), s, np.zeros(post_silent1) ) ) * signal_strength
s2 = np.concatenate( ( np.zeros(pre_silent2), s, np.zeros(post_silent2) ) ) * signal_strength
s3 = np.concatenate( ( np.zeros(pre_silent3), s, np.zeros(post_silent3) ) ) * signal_strength
s4 = np.concatenate( ( np.zeros(pre_silent4), s, np.zeros(post_silent4) ) ) * signal_strength

# Embed noise
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

