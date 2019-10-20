import numpy as np
from scipy import signal
import matplotlib.pyplot as plt
f = 5
dur = 1
fs = 100
t = np.linspace( 0, dur, dur*fs )
s1 = signal.square(2 * np.pi * f * t )
s2 = signal.square(2 * np.pi * f * (t - (0.5)))
plt.plot(t,s1)
plt.plot(t,s2)
plt.show()

