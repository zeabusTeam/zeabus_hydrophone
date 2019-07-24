from lowpass import h_lp
import scipy.optimize as opt
from hydrophone_serial import hydrophone_serial
import numpy as np
from bearingEstimator import bearingEstimator
import demodulation
import matplotlib.pyplot as plt

from scipy.signal import butter, lfilter

def butterworth_bandpass_filter( sig, lowcut, highcut, f_sampling, order=9 ):
    nyq = 0.5 * f_sampling
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter( order, [low, high], btype='band' )
    sig_out = lfilter( b, a, sig )
    return sig_out

# Main part
if __name__ == '__main__':

    ########################## setting parameter #################################

    Sampling_rate = 191930
    Frequency = 37500
    LowestFrequency = 20000
    HighestFrequency = 45000
    SoundSpeed = 1500
    FrontThreshold = 0.3
    PowerThreshold = 0.02
    DelayObserve = 2000
    LNA_Gain = 0.2

    ##############################################################################

    s = hydrophone_serial( '/dev/cu.usbmodem14103' )
    s.sent_dsp_param(Frequency, LowestFrequency, HighestFrequency, FrontThreshold, PowerThreshold, DelayObserve, LNA_Gain)
    f = open('/Users/Pongkemon/hydrophone.log', 'ab' )

    while True:

        # Receive an array of signal consisting of 4 signal streams. Each stream is 2048 elements of ADC value in 4-byte float
        sig, freq = s.get_pulse_data()
        np.save( f, sig )
        f.flush()
        if( freq == Frequency ):
            # Crop only the signal from index 800 to 1499 (the total signal index is 0 - 2047)
            sig = sig[:, 800:1500]

            complex_baseband = demodulation.demodulation(sig, Sampling_rate, Frequency)

            br = bearingEstimator(complex_baseband, np.array([[0, 0], [20, 0], [20, 20], [0, 20]]),
                                      Frequency / 1000.0, Sampling_rate / 1000.0)

            br.delay_time_estimator(1)
            az, ev, az_init, ev_init = br.bearingEstimatorForT0(1, fine_tune=True)

            print("The estimated arrival angle:")
            print("Azimuth: %f, Elevation: %f" % (az, ev))
            print("#########################################################################################")
        else:
            print( "Hydrophone in: Got a signal at ", freq,  " Hz.")
            print("#########################################################################################")
