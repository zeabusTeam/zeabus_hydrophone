import numpy as np
from matplotlib import pyplot as plt

fs = 64000000    # Sampling frequency
f = 25000        # Frequency of the pinger
period = 0.0001   # Period of the signal activity (100 us)

# Generate time axis
t = np.linspace(0, period, fs * period)
# Generate signal
y = np.sin(f * 2 * np.pi * t) * 2047
# Generate noise
n = np.random.normal(0, 0.7, size=t.size) * 511

# Final signal
s = y + n

plt.plot(s)
plt.show()

# convert to int16
s = np.uint16(np.int16(s))

for i in range(s.size):
    print("%04X"%(s[i]))
