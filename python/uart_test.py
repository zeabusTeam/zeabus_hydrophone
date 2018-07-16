import serial
import struct
import numpy as np
import pickle

pi = np.pi

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
        self.lamb = self.v_sound / f0
        self.f0 = f0
        self.fs = fs
        self.pulse = pulses
        self.locs = locs
        self.num_ants = locs.shape[0]
        self.loc2normlizedloc()
    
    def loc2normlizedloc(self):
        """
        Determine relative and normalized hydrophone locations
        :return: locations in x and y
        """
        x_loc = self.locs[:, 0] / self.lamb
        y_loc = self.locs[:, 1] / self.lamb
        x_mid = x_loc.mean()
        y_mid = y_loc.mean()
        x_loc = x_mid - x_loc
        y_loc = y_mid - y_loc
        # print x_loc, y_loc
        self.x_loc = x_loc
        self.y_loc = y_loc
        # compute maximum phase errors
        phaseerrors = np.zeros((self.num_ants, self.num_ants), 'float32')
        for k in range(self.num_ants):
            for m in range(self.num_ants):
                phaseerrors[k, m] = (self.x_loc[k] - self.x_loc[m]) ** 2 + (self.y_loc[k] - self.y_loc[m]) ** 2
        self.phaseerrors = np.sqrt(phaseerrors) * 2 * pi
        # print self.phaseerrors*180/pi


    def delay_time_estimator(self, down_sampling_rate):
        """
        Estimate arrival times and number of multiplaths
        :param down_sampling_rate: downsampling rate must be integer>=1
        :return: arrival times
        """
        h = self.pulse[:, ::down_sampling_rate].T.copy()  # down sampling to reduce storate space
        h = np.nan_to_num(h)
        n_ants, pulse_length = h.T.shape
        print("n_ants :",n_ants)
        print("pulse_length :",pulse_length)
        AA = np.ones((pulse_length, pulse_length))
        # print("AA :",AA)
        AA = np.tril(AA)
        h2 = h.T.copy()
        # print("h2 :",h2)
        ckminbest = 0
        AA2 = AA.T.copy()
        # print("AA2 :",AA2)
        
        for k in range(pulse_length): ### normalize AA2
            AA2[k] = AA[:, k].T / np.linalg.norm(AA[:, k])
        # print("AA2 :",AA2)

        k_best = 0
        k_min = pulse_length
        print(AA2.shape, h2.shape)
        erbest = np.linalg.norm(h2)
        print("initial norm: ", erbest)
        A_used = None
        k_a = []
        for m in range(15):
            CK = np.dot(AA2, h2.T)
            Ck2 = np.abs(CK).sum(1)
            k_best = np.nonzero(Ck2 == Ck2.max())[0][0]
            k_best = np.nonzero(Ck2 == Ck2.max())
            print(k_best)
            if A_used is None:
                A_used = AA2[k_best].reshape(1, pulse_length)
            else:
                temp = AA2[k_best].reshape(1, pulse_length)
                A_used = np.vstack((A_used, temp))
            P = np.dot(A_used, A_used.T)
            # print P.shape
            P = np.dot(np.dot(A_used.T, np.linalg.inv(P)), A_used)
            P = np.eye(pulse_length) - P
            for k in range(n_ants):
                h2[k] = np.dot(P, h2[k])
            k_a.append(k_best)

        ka = np.array(k_a)
        k_min = ka.min()


        # AAi = np.linalg.inv(AA)
        # print AAi
        # xx = np.dot(AAi,h)
        # np.savetxt(r"C:\Users\Teerasit\Dropbox\UAV\xx.csv",np.abs(xx).sum(1))

        tau = [0]
        #First pulse at t = 0
        V = np.zeros((pulse_length, 2))
        V[:, 0] = 1.0  # First column are all 1.0

        eout = np.zeros((pulse_length,))
        for t in range(3, pulse_length):
            # shift location of starting pulse in the second column
            V[:, 1] = 0
            V[t:, 1] = 1
            VH = V.T.conj()
            P = np.real(np.dot(VH, V))
            P = np.linalg.inv(P)
            c1 = np.dot(VH, h)

            # P = np.real(np.dot(np.dot(V,P),VH))

            e2 = np.trace(np.dot(c1.T.conj(), np.dot(P, c1)))  # main objective function
            eout[t] = np.real(e2)
            if ((eout[t - 1] > eout[t - 2]) & (eout[t - 1] > eout[t]) & (t > 3)):  # search for local maxima
                tau.append(t - 1)  # add the local optima in the list
        tau = [k_min]
        print('We found %f paths' % len(tau))
        print("at time  =", tau)
        self.tau = tau  # result

if __name__ == "__main__":

    ########################## setting parameter #################################

    Sampling_rate = 191930
    Frequency = 30000
    SoundSpeed = 1500
    FrontThreshold = 0.3
    PowerThreshold = 0.02
    DelayObserve = 2000

    ##############################################################################

    # s = serial.Serial('com4',115200,bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)

    # res = []
    # res.append(61)
    # res.append(61)
    # res.append(61)
    # res.append(61)
    # tmp = struct.pack('I', Frequency)
    # res.append(tmp[0])
    # res.append(tmp[1])
    # res.append(tmp[2])
    # res.append(tmp[3])
    # tmp = struct.pack('I', SoundSpeed)
    # res.append(tmp[0])
    # res.append(tmp[1])
    # res.append(tmp[2])
    # res.append(tmp[3])
    # tmp = struct.pack('f', FrontThreshold)
    # res.append(tmp[0])
    # res.append(tmp[1])
    # res.append(tmp[2])
    # res.append(tmp[3])
    # tmp = struct.pack('f', PowerThreshold)
    # res.append(tmp[0])
    # res.append(tmp[1])
    # res.append(tmp[2])
    # res.append(tmp[3])
    # tmp = struct.pack('I', DelayObserve)
    # res.append(tmp[0])
    # res.append(tmp[1])
    # res.append(tmp[2])
    # res.append(tmp[3])  

    # s.write(res)
    # s.flush()
    # N = 100
    # sig_re_1 = []
    # sig_re_2 = []
    # sig_re_3 = []
    # sig_re_4 = []
    # sig_im_1 = []
    # sig_im_2 = []
    # sig_im_3 = []
    # sig_im_4 = []

    # for i in range(N):
    #     sig_re_1.append(0.0)
    #     sig_re_2.append(0.0)
    #     sig_re_3.append(0.0)
    #     sig_re_4.append(0.0)
    #     sig_im_1.append(0.0)
    #     sig_im_2.append(0.0)
    #     sig_im_3.append(0.0)
    #     sig_im_4.append(0.0)

    # count = 0
    # while True:
    #     while True:
    #         x = s.read(1)
    #         if x == b'\xff':
    #             # print(x)
    #             x = s.read(1)
    #             # print(x)
    #             count +=1
    #             if x == b'\xff':
    #                 x = s.read(14)
    #                 # print(x)
    #                 count = 0
    #                 break

                
    #     seq = struct.unpack('<H', x[0:2])
    #     freq = struct.unpack('<I', x[2:6])
    #     time_between_pulse = struct.unpack('<I', x[6:10])
    #     processing_time = struct.unpack('<I', x[10:14])

    #     print ("seq : %d" %seq)
    #     print ("freq : %d" %freq)
    #     print ("time_between_pulse : %d" %time_between_pulse)
    #     print ("processing_time : %d" %processing_time)

    #     x = s.read(1)
    #     x = s.read(1)
    
    #     x = s.read(1600)

    #     start_id = 0

    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_re_1[i],) = struct.unpack('@f', x[(a + (i * 4)) :(a + (i * 4) + 4)])
    #         start_id = start_id + 4
        
    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_re_2[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4

    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_re_3[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4

    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_re_4[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4

    #     x = s.read(1)
    #     x = s.read(1)

    #     x = s.read(1600)
    #     start_id = 0
    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_im_1[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4
        
    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_im_2[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4
        
    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_im_3[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4

    #     a = start_id
    #     for i in range(0, 100):
    #         (sig_im_4[i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
    #         start_id = start_id + 4

    #     x = s.read(1)
    #     x = s.read(1)

    #     array = np.arange(400).reshape(4, 100)
    #     sig = np.zeros_like(array, np.complex)

    #     for i in range(0, 100):
    #         sig[0,i] = complex(sig_re_1[i],sig_im_1[i])
    #         sig[1,i] = complex(sig_re_2[i],sig_im_2[i])
    #         sig[2,i] = complex(sig_re_3[i],sig_im_3[i])
    #         sig[3,i] = complex(sig_re_4[i],sig_im_4[i])

    f = open('store.pckl', 'rb')
    sig = pickle.load(f)
    f.close()

    # print(sig)

    br = bearingEstimator(sig, np.array([[0, 0], [20, 0], [20, 20], [0, 20]]), Frequency, Sampling_rate)

    br.delay_time_estimator(1)

        # f = open('store.pckl', 'rb')
        # obj = pickle.load(f)
        # f.close()
