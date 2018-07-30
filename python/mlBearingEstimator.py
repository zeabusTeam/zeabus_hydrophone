__author__ = 'Teerasit Kasetkasem'
import time
import pickle
import  csv

import matplotlib.pyplot as plt
import numpy as np
import scipy.signal as sgn

hlp = np.array([  -0.0008453470597592304,
  -0.002712473014466144,
  -0.005788634958659003,
  -0.009171023634709823,
  -0.010705955411809303,
  -0.007218961126548628,
  0.004526073044614337,
  0.02637759604805089,
  0.05743262361200088,
  0.09345642810292086,
  0.12755817815137688,
  0.15206931577086633,
  0.16099477910402013,
  0.15206931577086633,
  0.12755817815137688,
  0.09345642810292086,
  0.05743262361200088,
  0.026377596048050886,
  0.004526073044614337,
  -0.007218961126548632,
  -0.010705955411809303,
  -0.009171023634709823,
  -0.0057886349586590115,
  -0.0027124730144661396,
  -0.0008453470597592304
])


data_file = r"C:\Users\User\Dropbox\UAV\NewFile6\NewFile0AA.csv"

pi = np.pi

class source :
    def __init__(self, starting_time, pulse_length, period, frequency, v_peak):
        """
        Initialize the source class

        :param starting_time: the offset time in ms
        :param pulse_length:  a pulse length in ms
        :param period: pulse repeating cycle in ms
        :param frequency: the modulated frequency in kHz
        :param v_peak: the peak voltage in volt.
        :return: none
        """
        self.ts = starting_time
        self.tp = pulse_length
        self.fo = frequency
        self.vp = v_peak
        self.period = period
    def generate_signal(self, observation_time, sampling_rate):
        """
        generate the signal pulse(s)

        :param observation_time: observed time period in ms
        :param sampling_rate: the sampling frequency of the signal in kHz
        :return: complex sinusoidal signal at self.fo during the observation time
        """
        self.ob_time = observation_time
        self.fs = sampling_rate

        num_samples = int(self.ob_time*self.fs) # determine the number of pulses

        t = np.arange(num_samples).astype("float64")*(self.ob_time/float(num_samples))
        s = self.vp*np.exp(1j*2*pi*self.fo*t) # The generated signal
        n_p = int(self.period*sampling_rate) # number of samples per period
        n_s = int(self.ts*sampling_rate)
        n_l = int(self.tp*sampling_rate)
        #print n_p, n_s, n_l
        generated_signal = np.zeros_like(s)
        for n in range(n_s, num_samples, n_p) :
            generated_signal[n:(n+n_l)] = s[n:(n+n_l)]

        return generated_signal

class multi_array_channel :
    def __init__(self, num_paths, noise_power, sig_freq, max_delay, max_multipath_gain, num_mics = 4):
        """
        This function initialize the multi_array_channel class

        :param num_paths: number of multipaths. The total paths is equal to num_paths +1
        :param noise_power: the noise power in dB
        :param sig_freq: the signal frequecny in kHz
        :param max_delay: Maximum multipath delay in ms
        :param max_multipath_gain: averaged total multipath power
        :param num_mics: number of received microphone
        :return: None
        """
        self.n_paths = num_paths
        self.noise_mag = 10.0**(noise_power/20)
        self.max_delay = max_delay
        self.max_multipath_gain = 10.0**(max_multipath_gain/20.0)
        self.fs = sig_freq
        self.lamb = 1500./sig_freq
        self.num_mics = num_mics

       # print self.max_multipath_gain


    def hydrophone_arrangement(self, locs):
        """
        Determine the relative hydrophone locations normalized by wavelength
        :param locs: location of hydrophone in x, y plane
        :return:
        """

        self.x_loc = locs[:,0]/self.lamb
        self.y_loc = locs[:,1]/self.lamb
        x_mid = self.x_loc.mean()
        y_mid = self.y_loc.mean()
        self.x_loc -= x_mid
        self.y_loc -= y_mid


    def phase_delay(self, az, elv):
        """
        Compute the relative phase delay for all hydrophone for a given azimuth and elevation angles
        :param az: Azimuth angle in degree
        :param elv: Elevation angle in degree
        :return: complex phase shift gain
        """
        az = pi*az/180.0
        elv = pi*elv/180.0
        phase_shift = -2*pi*(self.x_loc*np.sin(elv)*np.cos(az) + self.y_loc*np.sin(elv)*np.sin(az))
        complex_phase_shift = np.exp(1j*phase_shift)
        complex_phase_shift = np.diag(complex_phase_shift)
        return complex_phase_shift


    def generate_received_signal(self, transmitted_signal, sampling_feq, azimuth, elevation):
        """
        Generate received signals at all hydrophones with multipaths and noises
        :param transmitted_signal:  transmitted signal pulse
        :param sampling_feq: sampling frequency
        :param azimuth: arrival angles of  main path in azimuth direction in degree
        :param elevation:  arrival angles of  main path in elevation direction in degree
        :return: received signal vector
        """

        # determine the phase delay of main pulse
        v = self.phase_delay(azimuth,elevation)

        n_samples = transmitted_signal.size
        s = transmitted_signal.reshape((1,n_samples))
        # make copies of transmitted signals to match number of hydrophone
        s = s.repeat(self.num_mics,0)

        #multiply phase delay to the signal
        rec_noiseless_signal = np.dot(v,s)

        #determine the delay times for all multipaths
        path_delays = np.random.uniform(0, self.max_delay, self.n_paths)
        n_delays = (path_delays*sampling_feq).astype("int32")

        # Randomly determine the gain magnitude and phasefor all multipaths
        gains = np.random.rayleigh(self.max_multipath_gain, self.n_paths) # use rayleigh for magnitude
        phases = np.random.uniform(0,2*pi,self.n_paths) # uniform for phase
        complex_gains = gains*np.exp(1j*phases) # multipath gain

        n_samples = transmitted_signal.shape[0]
        for p in range(self.n_paths) :
            azp = np.random.uniform(-180,180) # randomly choose the arrival angles for all multipaths
            elvp = np.random.uniform(0,90)

            v = self.phase_delay(azp,elvp) #determine the corresponding phase delays

            # determine the noiseless received signal for the given multipath
            reflected_sig = np.zeros_like(s)
            reflected_sig[:,n_delays[p]:] = s[:,:(n_samples-n_delays[p])]
            reflected_sig = np.dot(v,complex_gains[p]*reflected_sig)
            rec_noiseless_signal += reflected_sig # add it to the received signal

        noise_p = np.random.normal(0,self.noise_mag,(self.num_mics,n_samples)) # add noises
        rec_noiseless_signal += noise_p

        return rec_noiseless_signal


class analogFrontend :
    def __init__(self, fo, bandwidth, filter_orders, sampling_freq, num_samples):
        """
        Create a frontend of the amplifier circuit.
        Here, the bandpass Butterworth filter is used.
        :param fo: central frequency of the filter in kHz
        :param bandwidth: bandwidth in kHz
        :param filter_orders: filter order must be integer
        :param sampling_freq: #sampling frequency in kHz
        :param num_samples: #number of samples
        :return: None
        """
        self.fs = sampling_freq
        self.fo = fo
        self.bw = bandwidth
        self.orders = filter_orders
        self.num_sampples = num_samples
        self.make_filter()




    def make_filter(self):
        """
        make butterworth filter
        :return: Transfer function of filter
        """
        fl = pi*(self.fo-self.bw/2.0)*2
        fh = pi*(self.fo+self.bw/2.0)*2
        b,a =sgn.butter(self.orders,np.array([fl,fh]),btype="bandpass",analog =True) # use this one to create filter
        fm = self.fs/2.0
        f = np.linspace(-fm, fm, self.num_sampples)
        s = 1j*2*pi*f
        w, h = sgn.freqs(b,a,2*pi*f)
        self.H = h #Here is the FFT of filter



    def filtering(self, sig):
        """
        filter the received signal
        :param sig: received signal at the hydrophone array
        :return: filtered signal
        """

        (N, n_samples) = sig.shape
        filtered_sig = np.zeros_like(sig)

        for n in range(N) :
            # we use multiplication in frequency domain to filter the received signals.
            s = sig[n,:]
            S = np.fft.fft(s)
            S = np.fft.fftshift(S)
            Y = S*self.H
            Y = np.fft.ifftshift(Y)
            y = np.fft.ifft(Y)
            filtered_sig[n, :] = y
            filtered_sig[n, 0:1000] = 0.0
        self.filtered_sig = filtered_sig

    def sampling(self, fs):
        """
        Sampling the received signal at the given frequency
        :param fs: sampling frequency in kHz where fs < self.sampling_freq
        :return: sampled signal
        """
        N = int(self.fs/fs)
        sampled_sig = self.filtered_sig[:,::N]
        return sampled_sig

class demodulate_module :
    """
    demodulation module
    """
    def __init__(self, sig, fo, sampling_rate):
        """
        Initialization
        :param sig: received signal
        :param fo: centeral frequency in kHz
        :param sampling_rate: sampling rate in kHz
        :return: None
        """
        n_ants, n_samples = sig.shape
        self.n_samples = n_samples
        self.n_ants = n_ants
        self.fo = fo
        self.sig = sig
        self.fs = sampling_rate
        self.t_max = n_samples/sampling_rate
    def demoduate(self):
        """
        Perform demodulation
        :return: demoduated pulses.
        """

        t= np.arange(self.n_samples).astype("float64")*(self.t_max/float(self.n_samples))


        carrier = np.exp(1j*2*pi*self.fo*t) #create the sinusoidal signal from the local oscilator.


        ylpf = np.zeros_like(self.sig)
        for n in range(self.n_ants) :
            y = np.real(self.sig[n,:])*carrier # multiply the received signal with local signal
            # perform lowpass filter with filter hlp given on the top of the file.
            ylpf[n,:] = np.convolve(y,hlp,'same')

        return ylpf

def pulseDetection(basedBandSignal, pulse_width, sampling_freq) :
    """
    Detect the signal pulse
    :param basedBandSignal: demodulated signal
    :param pulse_width: pulse width in ms
    :param sampling_freq: sampling frequency in kHz
    :return: the detected location and the puls
    """

    n_arrays, n_samples = basedBandSignal.shape
    n_per_pulse = int(pulse_width*sampling_freq)
    # determine the signal power
    envelop = np.abs(basedBandSignal)**2
    power = envelop.sum(0)
    p_min = 1e10
    h = 0.5
    p = 0
    p_avg = 0.0

    for n in range(50,n_samples) :
        p_avg  = p_avg *(float(n))/(float(n+1)) + power[n]*1.0/(float(n+1))
        p = power[n]
        p_min = min(p,p_min)
        if p > (p_avg+h) :# #(p_min+h):
            break
    pulse = basedBandSignal[:,n:(n+n_per_pulse)]
    #print pulse.shape
    return n, pulse

#


class bearingEstimator:
    """
    The main class used to estimate bearing and arrival time
    """
    def __init__(self, pulses, locs, f0, fs):
        """
        Initialization
        :param pulses: the received pulse
        :param locs: hydrophone locations in mm
        :param f0: signal frequency in kHz
        :param fs: sampling frequency in kHz
        :return:
        """
        self.v_sound = 1500.0
        self.lamb = self.v_sound/f0
        self.f0 = f0
        self.fs = fs
        self.pulse = pulses
        self.locs = locs
        self.loc2normlizedloc()

    def loc2normlizedloc(self):
        """
        Determine relative and normalized hydrophone locations
        :return: locations in x and y
        """
        x_loc = self.locs[:,0]/self.lamb
        y_loc = self.locs[:,1]/self.lamb
        x_mid = x_loc.mean()
        y_mid =y_loc.mean()
        x_loc -= x_mid
        y_loc -= y_mid
        #print x_loc, y_loc
        self.x_loc = x_loc
        self.y_loc = y_loc

    def delay_time_estimator(self, down_sampling_rate):
        """
        Estimate arrival times and number of multiplaths
        :param down_sampling_rate: downsampling rate must be integer>=1
        :return: arrival times
        """
        h = self.pulse[:,::down_sampling_rate].T.copy()  #down sampling to reduce storate space
        n_ants, pulse_length = h.T.shape

        tau =[]
        # First pulse at t = 0
        V = np.zeros((pulse_length, 2))
        V[:,0] = 1.0 # First column are all 1.0

        eout = np.zeros((pulse_length,))
        for t in range(3,pulse_length):
            #shift location of starting pulse in the second column
            V[:,1] = 0
            V[t:,1] = 1
            VH = V.T.conj()
            P = np.real(np.dot(VH,V))
            P = np.linalg.inv(P)
            c1 = np.dot(VH,h)

            #P = np.real(np.dot(np.dot(V,P),VH))

            e2 = np.trace(np.dot(c1.T.conj(),np.dot(P,c1))) #main objective function
            eout[t] = np.real(e2)
            if ((eout[t-1] > eout[t-2]) & (eout[t-1] > eout[t]) &(t >3)) : # search for local maxima
                tau.append(t-1)    # add the local optima in the list
        self.tau = tau # result


    def bearingEstimatorForT0(self, down_sampling_rate, fine_tune = True):
        """
        Main function to estimate bearing angles in both azimuth and elevation directions
        :param down_sampling_rate: down sampling rate must be integer >=1 and used in delay_time_estimator
        :param fine_tune: Enable the fine tuning process
        :return: the bearing angles in degree for both with and without fine tuning
                 In case fine_tune = False, both bearing angles will come form the estimation without fine tuning
        """
        h = self.pulse[:,::down_sampling_rate].T.copy()  #down sampling to reduce storate space
        n_ants, pulse_length = h.T.shape
        tau = self.tau
        V = np.zeros((pulse_length, len(tau)+1))
        #create V_tau matrix
        V[:,0] = 1
        for p in range(len(tau)) :
            V[tau[p]:,p+1] = 1.0
        VH = V.T.conj()
        P = np.dot(VH,V)
        P = np.linalg.inv(P)
        C= np.dot(P,np.dot(VH,h))
        C0 = C[0,:].reshape(n_ants,1) # use only first row for main pulse
        creal = np.real(C0) # real part
        cimg = np.imag(C0) # imaginary part
        phase_c = np.arctan2(creal , cimg)/(2*pi) # compute phase of each elevement in C0

        """
        Here, we have [psi*x, psi*, 1]*y[sx st, z]' = [phase_c01, ..., phase_c0M]'
        The least square is used to find the solution.

        """
        A = np.array([-self.x_loc, -self.y_loc, np.ones((n_ants))]).T # Create a matrix X
        out = np.linalg.lstsq(A,phase_c)
        out = out[0] # leastsq return many things. We need only the first one.
        #elv angle = arcsin( sqrt( sx^2  + sy^2) )
        sin_elv = min(np.sqrt(out[0,0]**2 + out[1,0]**2),1.0)
        elv_t_r = np.arcsin(sin_elv)
        # azimuth = arctan(sy/sx)
        az_t_r = np.arctan2(out[1,0], out[0,0])
        az_t = az_t_r*180/pi
        elv_t = elv_t_r*180/pi
        #print "initial = %f, %f"%(az_t, elv_t)

        # perform newton method to find the nearest local maximum point
        if fine_tune :
            finding_root = True
            # use the least square result as the initial value
            az0 = az_t_r
            ev0 = elv_t_r
            # compute gradient and inverse hessian matrix
            g, B= self.gradient(C0, az0, ev0)

            if np.linalg.norm(g) < 1e-4: # if gradient is small stop. Otherwise do the fine tine
                finding_root = False

            while (finding_root):

                # compute the initial gradient and inverse hessian matrix
                g, B= self.gradient(C0, az0, ev0)
                # determine the search direction
                # d = Bg
                d = np.dot(B[0],g[0])

                # performing the line search for optimum parameter
                alpha = 1.0e-2 # initial alpha should be small
                norm_g_old = np.linalg.norm(g) #magniture of current gradient
                norm_g_new = norm_g_old +1 # magniture of new gradient
                cnt = 0
                tor = 1e-6*norm_g_old
                # the line search will find proper alpha that reduce the gradient
                # we only repeat the line search for only 20 iterations
                while ((norm_g_old < norm_g_new) ) & (cnt <20) :
                    cnt += 1
                    alpha = alpha/2.0 # alpha is too large. Decrease it by a factor of 2
                    # find new azimuth and elevation angle
                    # b= b0-\alpha*B*g
                    azn = az0 - alpha*d[0]
                    evn = ev0 - alpha*d[1]
                    # if the angles are out of range move them back in the range.
                    if azn > pi:
                        azn = pi-azn
                    elif azn<-pi:
                        azn = pi+azn
                    if evn > pi/2.0:
                        evn = pi-evn
                    elif evn < 0.0:
                        evn = -evn

                    #determine new gradient
                    gn, Bn= self.gradient(C0, azn, evn)
                    norm_g_new = np.linalg.norm(gn)


                if cnt < 20 :
                    # perform line search 20 iterations
                    # It implies no improvement
                    # Stop the searching
                    error = np.sqrt((az0-azn)**2 + (ev0-evn)**2)
                    az0 = azn
                    ev0 = evn
                else:
                    error = 0

                if error < 1e-6 :
                    finding_root = False
            az = az0*180/pi
            ev = ev0*180/pi
            return az, ev, az_t , elv_t
        else:
            return az_t, elv_t, az_t , elv_t



    def gradient(self, c, azr, evr):
        """
        Compute the gradient at given azimuth and elevation angle in radian
        :param c: C0
        :param azr: azimuth angle in radian
        :param evr: elevation angle in radian
        :return: gradient vector and inverse hessain matrix
        """


        sx = np.sin(evr)*np.cos(azr)
        sy = np.sin(evr)*np.sin(azr)
        psi = 2*pi
        d_a_d_sx = 0
        d_a_d_sy = 0
        d2_a_d_sx2 = 0
        d2_a_d_sy2 = 0
        d2_a_d_sx_sy = 0
        cost2 = 0 #cost2[0,0]
        ch = c.conj()
        # compute the first and second derivative with respect to sx and sy first
        for i in range(4) :
            for j in range(i+1, 4) :
                cr = np.real((c[i]*ch[j]))[0]
                ci = np.imag((c[i]*ch[j]))[0]
                dx = self.x_loc[j]-self.x_loc[i]
                dy = self.y_loc[j]-self.y_loc[i]
                dcr = cr*np.sin(2*pi*(dx*sx+dy*sy))
                dci = -ci*np.cos(2*pi*(dx*sx+dy*sy))
                d_a_d_sx += 2.0*(-dcr*dx+dci*dx)*psi
                d_a_d_sy += 2.0*(-dcr*dy+dci*dy)*psi
                d2cr = cr*np.cos(2*pi*(dx*sx+dy*sy))
                d2ci = -ci*np.sin(2*pi*(dx*sx+dy*sy))
                d2_a_d_sx2 -= 2.0*(d2cr*dx*dx+d2ci*dx*dx)*psi*psi
                d2_a_d_sy2 -= 2.0*(d2cr*dy*dy+d2ci*dy*dy)*psi*psi
                d2_a_d_sx_sy -= 2.0*(d2cr*dx*dy+d2ci*dx*dy)*psi*psi
         # make the gradient vector for sx and sy
        gs = np.array([d_a_d_sx, d_a_d_sy])

        # convert to gradient vector wrt to phi and theta
        d_sx_d_az = -np.sin(evr)*np.sin(azr)
        d_sx_d_ev = np.cos(evr)*np.cos(azr)
        d_sy_d_az = np.sin(evr)*np.cos(azr)
        d_sy_d_ev = np.cos(evr)*np.sin(azr)
        # Compute the gradient vector wrt bearing angles
        jg = np.array([[d_sx_d_az, d_sy_d_az],[d_sx_d_ev, d_sy_d_ev]])
        gb = np.dot(jg, gs)


        # convert to hassian matrix wrt to phi and theta

        d2_sx_d_az2 = -np.sin(evr)*np.cos(azr)
        d2_sx_d_ev2 = -np.sin(evr)*np.cos(azr)
        d2_sy_d_az2 = -np.sin(evr)*np.sin(azr)
        d2_sy_d_ev2 = -np.sin(evr)*np.sin(azr)
        d2_sx_d_az_ev = -np.cos(evr)*np.sin(azr)
        d2_sy_d_az_ev = -np.cos(evr)*np.cos(azr)

        hs = np.array([d2_a_d_sx2, d2_a_d_sx_sy, d2_a_d_sy2, d_a_d_sx, d_a_d_sy])
        jh =np.array([[d_sx_d_az**2, d_sx_d_az*d_sy_d_az, d_sy_d_az**2, d2_sx_d_az2, d2_sy_d_az2] \
                    ,[d_sx_d_az*d_sx_d_ev, d_sx_d_az*d_sy_d_ev, d_sy_d_az*d_sy_d_ev, d2_sx_d_az_ev, d2_sy_d_az_ev] \
                    ,[d_sx_d_ev**2, d_sx_d_ev*d_sy_d_ev, d_sy_d_ev**2, d2_sx_d_ev2, d2_sy_d_ev2]])
        hb = np.dot(jh, hs)
        Hb = np.array([[hb[0], hb[1]],[hb[1], hb[2]]])
        # find the inverse hassian matrix
        Bb = np.array([[hb[2], -hb[1]],[-hb[1], hb[0]]])
        Bb = Bb/(hb[2]*hb[0]-hb[1]**2)
        return gb, Bb





if __name__ == "__main__" :
    # create a source
    # pulse starts at 1ms
    # pulse length is 4 ms
    # repeat every 2 seconds
    # the modulated freq is 34 kHz
    # pulse amplitude 1 v

    src = source(10,4, 2000, 34, 1)
    # sampling at 30 times maximum sampling frequency of A2D
    fs = 191.93
    # generate the transmitted signal for 6 ms
    sig = src.generate_signal(96, fs)
    # random main path bearing
    az_true = -50
    elv_true = 45
    print("The actual arrival angle:")
    print("Azimuth: %f, Elevation: %f",az_true, elv_true)

    # create a multipath channel
    # with 100 paths
    # noise power -20 dB
    # operate at 34 kHz
    # maximum pulse delay 4 ms
    # each unwanted path max power is -10 dB
    chn = multi_array_channel(0, -20, 30, 4, -20)
    # set microphones at (0,0), (0,20), (20,0), (20,20) mm
    chn.hydrophone_arrangement(np.array([[0, 0], [20, 0], [20, 20], [0, 20]]))
    # generate received signal
    rec_sig = chn.generate_received_signal(sig, fs, az_true, elv_true)
    rec_sig = ((rec_sig.real / 8) + 0.5) * 65535
    rec_sig = rec_sig.astype(np.uint32)
    plt.plot(rec_sig[0, :])
    plt.plot(rec_sig[1, :])
    plt.plot(rec_sig[2, :])
    plt.plot(rec_sig[3, :])
    plt.show()
    num_samples = rec_sig.shape[1]
    print(num_samples)

    data12 = ""
    data34 = ""
    for k in range(num_samples):
        data12 += str(rec_sig[0, k]) +", " + str(rec_sig[1, k]) + ", "
        data34 += str(rec_sig[2, k])+ ", " + str(rec_sig[3, k]) + ", "



    with open('rec_sig12.txt', 'w', newline='') as file12:
        file12.write(data12)

    with open('rec_sig34.txt', 'w', newline='') as file34:
        file34.write(data34)




    
    t = np.linspace(0, 6, 192*30*6)
    plt.figure(1)
    for n in range(4):
        plt.subplot(4,1,n)
        plt.plot(t, np.real(rec_sig[n,:]))
        plt.xlabel("time (ms)")
        plt.title("the %d-th received signal"%n)
    plt.show(block = False)
    #plt.close()

    # Create Frontend bandpass filter circuit
    # at 34 kHz with bandwidth 10.0 kHz
    # filter order is 8
    # sampling rate = fs =30*192
    # for the signal size
    frontend = analogFrontend(30, 20.0, 4, fs, sig.size)
    frontend.filtering(rec_sig)
    sampled_sig = frontend.sampling(192)
    plt.figure(2)
    t = np.linspace(0,6,192*6)
    for n in range(4):
        plt.subplot(4,1,n)
        plt.plot(t, np.real(sampled_sig[n,:]))
        plt.xlabel("time (ms)")
        plt.title("the %d-th sampled signal"%n)
    plt.show(block = False)
    #plt.close()

    # Demodulate the signal
    # at 34 kHz with sampling rate of
    # 192 kHz (The maximum that AD can)
    demod = demodulate_module(sampled_sig, 34, 192)
    # Obtain baseband signal
    baseband  = demod.demoduate()
    t = np.linspace(0,6,192*6)
    plt.figure(3)
    for n in range(4):
        plt.subplot(4,1,n)
        plt.plot(t, np.real(baseband[n,:]))
        plt.xlabel("time (ms)")
        plt.title("the %d-th demodulated signal"%n)
    plt.show(block = False)

    # detect pulse
    n, pulse = pulseDetection(baseband, 4.0, 192)
    #print pulse.shape
    print(n)
    plt.figure(4)
    t = np.linspace(n/192.,n/192.+4.0,pulse.shape[1])
    for n in range(4):
        plt.subplot(4,1,n)
        plt.plot(t, np.real(pulse[n,:]))
        plt.xlabel("time (ms)")
        plt.title("the %d-th pulse"%n)
    plt.show(block = False)

    # extract only sure part.
    sub_pulse = pulse[:,3:-100]

    t1 =time.time()
    # Create athe bearingEstimator module
    # sub_pulse as input
    # set microphones at (0,0), (0,20), (20,0), (20,20) mm
    # signal freq. 34 kHz
    # Sampling rate: 192 kHz
    br = bearingEstimator(sub_pulse, np.array([[0,0],[0,20],[20,0],[20,20]]), 34, 192)
    # determine the arrival time with down sampling rate of 5
    br.delay_time_estimator(5)
    # estimate the arrival time of the main path with down sampling rate of 5
    az, ev, az_init, ev_init = br.bearingEstimatorForT0(5, fine_tune=True)
    t2 = time.time()
    print ("The estimated arrival angle:")
    print ("Azimuth: %f, Elevation: %f",az, ev)
    print ("with processing time: %f",t2-t1)
    # mode=raw_input('Press enter to exit:')




    # errors = np.zeros((2,100))
    # errors_init = np.zeros((2,100))
    # az_in = np.zeros((100))
    # az_out = np.zeros((100))
    # elv_in = np.zeros((100))
    # elv_out = np.zeros((100))
    # elv_in_init = np.zeros((100))
    # elv_out_init = np.zeros((100))
    # proc_time = np.zeros((100))
    # N_paths =[1,2,4,8,16,32,64,128]
    # P_path_total = [-5]
    # err_n_path = np.zeros((2,len(N_paths )))
    # err_n_path_init = np.zeros((2,len(N_paths )))
    # comptime = np.zeros((len(N_paths )))
    # for k in range(len(N_paths )):
    #
    #     n_paths = N_paths[k]
    #     P_path = P_path_total[0] - 10*np.log10(float(n_paths  ))
    #     print "number of path: %d"%n_paths
    #     print "power per path:%f (dB)"%P_path
    #     for it in range(100):
    #
    #         az_true = np.random.uniform(-180, 170)
    #         elv_true = np.random.uniform(10, 70)
    #         az_in[it] = az_true
    #         elv_in[it] = elv_true
    #         #print "actual az:%f\nelv:%f"%(az_true,elv_true)
    #
    #
    #         chn = multi_array_channel(n_paths, -10, 34, 4, P_path)
    #         #print "n paths =",n_paths
    #         chn.hydrophone_arrangement(np.array([[0, 0], [0, 20], [20, 0], [20, 20]]))
    #         rec_sig = chn.generate_received_signal(sig, fs, az_true, elv_true)
    #         # t = np.linspace(0,6,192*30*6)
    #         # for n in range(4):
    #         #     plt.subplot(4,1,n)
    #         #     plt.plot(t, rec_sig[n,:])
    #         # plt.show(block = False)
    #
    #
    #
    #
    #
    #         frontend = analogFrontend(34, 20.0, 8, fs, sig.size)
    #         frontend.filtering(rec_sig)
    #         sampled_sig = frontend.sampling(192)
    #         # t = np.linspace(0,6,192*6)
    #         # for n in range(4):
    #         #     plt.subplot(4,1,n)
    #         #     plt.plot(t, np.real(sampled_sig[n,:]))
    #         # plt.show()
    #         #.close()
    #
    #         demod = demodulate_module(sampled_sig, 34, 192)
    #         baseband  = demod.demoduate()
    #         n, pulse = pulseDetection(baseband, 4.0, 192)
    #         sub_pulse = pulse[:,3:-100]
    #         # for n in range(4):
    #         #     plt.subplot(4,1,n)
    #         #     plt.plot(np.real(sub_pulse[n,:]))
    #         # plt.show()
    #         # plt.close()
    #         R = np.dot(sub_pulse, sub_pulse.T.conj())/sub_pulse.shape[1]
    #         #print R
    #         #az, ev =musicAlgorithm(R, np.array([[0,0],[0,20],[20,0],[20,20]]), 1500./34.,-90, 90, 0, 90)
    #         #az, ev = bearingEstimator(R, sub_pulse, np.array([[0,0],[0,20],[20,0],[20,20]]), 1500./34, 5)
    #         t1 =time.time()
    #         br = bearingEstimator(sub_pulse, np.array([[0,0],[0,20],[20,0],[20,20]]), 34, 192)
    #         br.delay_time_estimator(5)
    #         az, ev, az_init, ev_init = br.bearingEstimatorForT0(5, fine_tune=True)
    #         t2 = time.time()
    #         proc_time[it]= t2-t1
    #         az_out[it] = az
    #         elv_out[it] = ev
    #         #print "resulting aziumth:%f\nresulting elvation:%f"%(az, ev)
    #         errors[0,it] = np.abs(az-az_true)
    #         errors[1,it] = np.abs(ev-elv_true)
    #         errors_init[0,it] = np.abs(az_init-az_true)
    #         errors_init[1,it] = np.abs(ev_init-elv_true)
    #
    #     print "average errors = ", errors.mean(1)
    #     print "error max", errors.max(1)
    #     print "average processing time: %f"%proc_time.mean()
    #     err_n_path[0,k] = errors.mean(1)[0]
    #     err_n_path[1,k] = errors.mean(1)[1]
    #     err_n_path_init[0,k] = errors_init.mean(1)[0]
    #     err_n_path_init[1,k] = errors_init.mean(1)[1]
    #     comptime[k] = proc_time.mean()
    #
    # plt.subplot(2,1,1)
    # #plt.title(""%(P_path_total))
    # plt.plot(np.array(N_paths ),err_n_path[0])
    # plt.ylabel("Azimuth Error (degrees)")
    # plt.xlabel("number of multipaths")
    # plt.grid()
    # plt.subplot(2,1,2)
    # plt.plot(np.array(N_paths),err_n_path[1])
    # plt.ylabel("Elevation Error (degrees)")
    # plt.xlabel("number of multipaths")
    # plt.grid()
    # plt.savefig("NumpathsVsErrorWithFineTune.png")
    # plt.close()
    #
    #
    # plt.subplot(2,1,1)
    # plt.plot(np.array(N_paths ),err_n_path_init[0])
    # plt.ylabel("Azimuth Error (degrees)")
    # plt.xlabel("number of multipaths")
    # plt.grid()
    # plt.subplot(2,1,2)
    # plt.plot(np.array(N_paths),err_n_path_init[1])
    # plt.ylabel("Elevation Error (degrees)")
    # plt.xlabel("number of multipaths")
    # plt.grid()
    # #plt.show()
    # plt.savefig("NumpathsVsErrorWithNoFineTune.png")
    # plt.close()
    # plt.plot(np.array(N_paths),comptime*1000.0)
    # plt.ylabel("computational time (ms)")
    # plt.xlabel("number of multipaths")
    # plt.savefig("CompTimeNumpathsVsErrorWithFineTune.png")
