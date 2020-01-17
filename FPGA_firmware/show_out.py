import numpy as np
from matplotlib import pyplot as plt

#data = np.loadtxt("hp_data.hex", dtype='int16', converters={0:lambda s:int(s,16)})
#data2 = np.loadtxt("hp_output.hex", dtype='int16', converters={0:lambda s:int(s,16)})
data3 = np.loadtxt("hp_output1.hex", dtype='int16', converters={0:lambda s:int(s,16)})

#plt.plot(data)
#plt.plot(data2)
plt.plot(data3)
plt.show()
