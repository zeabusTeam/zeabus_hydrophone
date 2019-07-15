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
    SoundSpeed = 1500
    FrontThreshold = 0.3
    PowerThreshold = 0.02
    DelayObserve = 2000
    LNA_Gain = 0.2

    ##############################################################################

    s = hydrophone_serial( '/dev/cu.usbmodem14103' )
    s.sent_dsp_param(Frequency, FrontThreshold, PowerThreshold, DelayObserve, LNA_Gain)

    fig, axis = plt.subplots(1, 1)
    plot_out = None

    while True:

        # Receive an array of signal consisting of 4 signal streams. Each stream is 2048 elements of ADC value in 4-byte float
        sig = s.get_pulse_data()

        # Crop only the signal from index 800 to 1499 (the total signal index is 0 - 2047)
        sig = sig[:, 800:1500]
        t = np.arange(sig.shape[1]) # Create an array of size 800:1500 storing a series of integer starting from 0
        if plot_out is None:
            plot_out = axis.plot(t, sig[0,:] , t, sig[1,:], t, sig[2,:], t, sig[3,:])
        else:
            for tt in range(4):
                plot_out[tt].set_data(t, sig[tt,:])

        axis.legend(["CH1", "CH2", "CH3", "CH4"])
        # fig.canvas.draw()
        # plt.show(False)
        # plt.pause(0.01)

        
        complex_baseband = demodulation.demodulation(sig, Sampling_rate, Frequency)

        br = bearingEstimator(complex_baseband, np.array([[0, 0], [20, 0], [20, 20], [0, 20]]),
                              Frequency / 1000.0, Sampling_rate / 1000.0)

        br.delay_time_estimator(1)
        az, ev, az_init, ev_init = br.bearingEstimatorForT0(1, fine_tune=True)

        print("The estimated arrival angle:")
        print("Azimuth: %f, Elevation: %f" % (az, ev))
        print("#########################################################################################")

