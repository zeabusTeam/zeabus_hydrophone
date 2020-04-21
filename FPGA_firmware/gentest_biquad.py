import numpy as np
from matplotlib import pyplot as plt
import sys

# def set_defaultencoding_globally(encoding='utf-8'):
#     assert sys.getdefaultencoding() in ('ascii', 'mbcs', encoding)
#     import imp
#     _sys_org = imp.load_dynamic('_sys_org', 'sys')
#     _sys_org.setdefaultencoding(encoding)

# set_defaultencoding_globally('utf-8')

fs = 200000    # Sampling frequency
f1 = 1000      # Frequency that is supposed to pass the filter
f2 = 8300     # Frequency that is supposed to be blocked
period = 0.01   # Period of the signal activity (10 ms)

# Generate time axis
t = np.linspace(0, period, np.int(fs * period))
# Generate signal
y1 = np.sin(f1 * 2 * np.pi * t)
y2 = np.sin(f2 * 2 * np.pi * t)
# Generate noise
n = np.random.normal(0, 0.5, size=t.size)

# Final signal
s = (y1 + y2 + n) / 3

# Scale to Q.15
s = s * 32767

plt.plot(s)
plt.show()

# convert to int16
s = np.uint16(np.int16(s))

for i in range(s.size):
    print("%04X"%(s[i]))
