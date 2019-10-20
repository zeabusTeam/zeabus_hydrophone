import numpy as np
import matplotlib.pyplot as plt
import math
from scipy import signal

f0 = 25000.0
f1 = 35000.0
fs = 5000000.0
dur = 5                      #seconds

def genTime(fs,dur):
    t = np.linspace( 0, dur, dur*fs )
    return t

def genSine(f,t,delay=0):
    sinewave = np.sin( 2 * np.pi * f * (t - delay ) )
    return sinewave

def genSquare(f,t,delay=0):
    squarewave = signal.square( 2 * np.pi * f * ( t - delay ) )
    return squarewave

def genNoise(dc_level,t):
    noise = np.random.normal( 0, 1, t.size)
    noise = noise + dc_level
    return noise

