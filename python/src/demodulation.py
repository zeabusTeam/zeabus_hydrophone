import numpy as np
from lowpass import h_lp

def demodulation(signal, sampling_rate, freq):
    n_ch, pulse_length = signal.shape
    t = np.arange(pulse_length).astype('float32')/sampling_rate
    td = 0.4/sampling_rate
    cos_term_even = np.cos(np.pi*2*freq*t)
    sin_term_even = np.sin(np.pi*2*freq*t)
    cos_term_odd = np.cos(np.pi * 2 * freq * t + 2 * np.pi *freq *td)
    sin_term_odd = np.sin(np.pi * 2 * freq * t + 2 * np.pi *freq *td)

    in_phaseout = np.zeros_like(signal)
    quar_phaseout = np.zeros_like(signal)
    for k in range(n_ch):
        if (k % 2 == 0) : #even
            in_phase = signal[k,:] * cos_term_even
            quar_phase = signal[k,:] * sin_term_even
        else:
            in_phase = signal[k,:] * cos_term_odd
            quar_phase = signal[k,:] * sin_term_odd

        in_phaseout[k, :] = np.convolve(in_phase, h_lp, 'same')
        quar_phaseout[k, :] = np.convolve(quar_phase, h_lp, 'same')
    return in_phaseout+1j*quar_phaseout