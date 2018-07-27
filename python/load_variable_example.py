import serial
import struct
import numpy as np
import pickle

f = open('store.pckl', 'rb')
sig = pickle.load(f)
f.close()

print(sig)