import numpy as np
import scipy.optimize as opt


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
        n_ants, pulse_length = h.T.shape
        print("n_ants :", n_ants)
        print("pulse_length :", pulse_length)
        AA = np.ones((pulse_length, pulse_length))
        # print("AA :",AA)
        AA = np.tril(AA)
        h2 = h.T.copy()
        # print("h2 :",h2)
        ckminbest = 0
        AA2 = AA.T.copy()
        # print("AA2 :",AA2)

        for k in range(pulse_length):  ### normalize AA2
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
            # k_best = np.nonzero(Ck2 == Ck2.max())[0][0]
            k_best = np.nonzero(Ck2 == Ck2.max())
            # print(k_best)
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

        #
        # # AAi = np.linalg.inv(AA)
        # # print AAi
        # # xx = np.dot(AAi,h)
        # # np.savetxt(r"C:\Users\Teerasit\Dropbox\UAV\xx.csv",np.abs(xx).sum(1))
        #
        # tau = [0]
        # #First pulse at t = 0
        # V = np.zeros((pulse_length, 2))
        # V[:, 0] = 1.0  # First column are all 1.0
        #
        # eout = np.zeros((pulse_length,))
        # for t in range(3, pulse_length):
        #     # shift location of starting pulse in the second column
        #     V[:, 1] = 0
        #     V[t:, 1] = 1
        #     VH = V.T.conj()
        #     P = np.real(np.dot(VH, V))
        #     P = np.linalg.inv(P)
        #     c1 = np.dot(VH, h)
        #
        #     # P = np.real(np.dot(np.dot(V,P),VH))
        #
        #     e2 = np.trace(np.dot(c1.T.conj(), np.dot(P, c1)))  # main objective function
        #     eout[t] = np.real(e2)
        #     if ((eout[t - 1] > eout[t - 2]) & (eout[t - 1] > eout[t]) & (t > 3)):  # search for local maxima
        #         tau.append(t - 1)  # add the local optima in the list
        tau = [k_min]
        print('We found %f paths' % len(tau))
        print("at time  =", tau)
        self.tau = tau  # result

    def make_A(self):
        A = np.array([2.0 * pi * self.x_loc, 2.0 * pi * self.y_loc, np.ones((self.num_ants))]).T
        self.A = A

    def make_AHA_inv(self):
        A = self.A
        AHA = np.dot(np.conj(A.T), A)
        AHA_inv = np.linalg.inv(AHA)
        self.AHA_inv = AHA_inv

    def solveLeastSq(self, b):
        AHb = np.dot(np.conj(self.A.T), b)
        x = np.dot(self.AHA_inv, AHb)
        return x

    def bearingEstimatorForT0(self, down_sampling_rate, fine_tune=True):
        """
        Main function to estimate bearing angles in both azimuth and elevation directions
        :param down_sampling_rate: down sampling rate must be integer >=1 and used in delay_time_estimator
        :param fine_tune: Enable the fine tuning process
        :return: the bearing angles in degree for both with and without fine tuning
                 In case fine_tune = False, both bearing angles will come form the estimation without fine tuning
        """

        h = self.pulse[:, ::down_sampling_rate].T.copy()  # down sampling to reduce storate space
        n_ants, pulse_length = h.T.shape
        tau = self.tau
        V = np.zeros((pulse_length, len(tau)))
        # create V_tau matrix
        # V[:,0] = 1
        for p in range(len(tau)):
            V[tau[p]:, p] = 1.0
        VH = V.T.conj()
        P = np.dot(VH, V)
        P = np.linalg.inv(P)
        C = np.dot(P, np.dot(VH, h))

        C0 = C[0, :].reshape(n_ants, 1)  # use only first row for main pulse
        # print C0
        creal = np.real(C0)  # real part
        cimg = np.imag(C0)  # imaginary part
        print("c_power:%f dBm" % (10.0 * np.log10((creal ** 2 + cimg ** 2).sum()) + 30))
        phase_c = np.arctan2(cimg, creal)  # compute phase of each elevement in C0
        # possible orders are:
        #   H1   H4
        #   H2   H3
        # 0< phi < 45: 3, 2, 4,1
        # 45 < phi < 90: 3,4,2,1
        # 90 < phi <135: 4,3, 1,2
        # 135 <phi <180: 4,1,3,2
        # -180<phi<-135: 1,4,2,3
        # -135<phi<-90: 1, 2,4,3
        # -90 <phi<-45: 2,1,3,4
        # -45< phi< 0: 2,3,1,4
        # Check phase errors

        phase_c = phase_c.flatten()
        print("computed phase of the first path result = ", phase_c * 180 / pi)
        print("Check for validity of input phases")
        #############################################################################################
        # This is a modified portion of the code.
        #
        # Since the hydrophones are placed at the fixed distance apart,
        # the phase differences should not exceed 360*d/lambda.
        # The phase differences can greater than 360*d/lambda due to the fact
        # that the phase of the vector C0 is computed with respect to the local oscillator,
        # and it will be rounded up to be between -180 and 180.
        # For example, if the actual phase are: H1: 20, H2: 90, H3: 160, H4: 240. The program will issued:
        # 20, 90, 160 and -100. This can lead to the mis-understanding that the signal arrive at
        # H4, H1, H2, H3, and phase differences are: H4-1:120, H4-2: 190: H4-3: 260: H1-2:70, H1-3: 70 and H2-3:70
        # If hydrophone are places in a square of distance 20 mm
        #  H1 H2
        #  H4 H3
        # With 35 KHz sound, the maximum phase differences between pairs are:
        # H1-4: 168, H1-2:168, H1-3: 237, H2-3:169, H2-4: 237. H3-4: 168
        # To cope with this problem, we first need to find out the hydrophone that the sound wave arrive first.
        # In this program, we use the combination that reaches most valid phase differences as a criteria:
        # After than we will check for impossible arrangement.
        # From the hydrophone locations, the received signals arriving pattern must satisfy the following properties
        # 1) If it arrives at H1 first, it will arrive at H3 last,
        # 2) If it arrives at H2 first, it will arrive at H4 last,
        # 3) If it arrives at H3 first, it will arrive at H1 last,
        # 4) If it arrives at H4 first, it will arrive at H1 last,
        # For the impossible arrangement, the cost will be highest

        error_min = 1e20
        for h in range(self.num_ants):
            # We search for each hydrophone to be the first
            # compute the phase differences
            phase_diff = (phase_c - phase_c[h]) % (2 * pi)
            error = phase_diff - self.phaseerrors[h]
            error = error * (error > 0)
            # print "error = ", error
            # print "phase_diff", phase_diff*180./pi
            # print "phase error", self.phaseerrors*180./pi
            error = error.sum()
            # print "error = ", error
            phs1 = list(phase_diff)
            phs2 = list(phase_diff)
            phs2.sort()
            idx = [phs1.index(k) for k in phs2]
            # print idx
            # Check for impossible arrival of signals
            # if (idx[0] == 0) & (idx[-1] != 2):
            #    error += 4*2*pi
            # elif (idx[0] == 2) & (idx[-1] != 0):
            #    error += 4*2*pi
            # elif (idx[0] == 1) & (idx[-1] != 3):
            #    error += 4*2*pi
            # elif (idx[0] == 3) & (idx[-1] != 1) :
            #    error += 4*2*pi

            # print " new phase  ",phase_diff*180./np.pi,", error = %f"%error
            if error < error_min:
                print("Found a more suitable arrangement with new phase = ", phase_diff * 180. / np.pi)
                error_min = error
                phase_use = phase_diff
        # print error_min
        # print
        phase_c = phase_use

        # end of the modification of the code
        ##############################################################################################

        # A = np.array([2.0*pi*self.x_loc, 2.0*pi*self.y_loc, np.ones((self.num_ants))]).T # Create a matrix X
        self.make_A()
        self.make_AHA_inv()
        print("A = ", (self.A))
        out = self.solveLeastSq(phase_c)

        # out = np.linalg.lstsq(A, phase_c)
        # out = out[0]
        # print out.shape

        sin_elv = min(np.sqrt(out[0] ** 2 + out[1] ** 2), 1.0)
        elv_t_r = np.arcsin(sin_elv)
        # azimuth = arctan(sy/sx)
        az_t_r = np.arctan2(out[1], out[0])
        az_t = az_t_r * 180 / pi
        elv_t = elv_t_r * 180 / pi
        print("initial = %f, %f" % (az_t, elv_t))

        bearing = [az_t_r, elv_t_r]

        # perform newton method to find the nearest local maximum point
        if fine_tune:  # From the experiment, the fine tune does not imporove anything.

            # I decided to use the python optimization libarary since it is much faster and give more accurate results.
            # However, I found out that the fine tuning is not necessary.
            out = opt.fmin_bfgs(computeCost, bearing, gCost, args=(self.x_loc, self.y_loc, C0))
            az = out[0] * 180. / pi
            ev = out[1] * 180. / pi
            return az, ev, az_t, elv_t
        else:
            return az_t, elv_t, az_t, elv_t

    def gradient(self, c, azr, evr):
        """
        Compute the gradient at given azimuth and elevation angle in radian
        :param c: C0
        :param azr: azimuth angle in radian
        :param evr: elevation angle in radian
        :return: gradient vector and inverse hessain matrix
        """

        sx = np.sin(evr) * np.cos(azr)
        sy = np.sin(evr) * np.sin(azr)
        psi = 2 * pi
        d_a_d_sx = 0
        d_a_d_sy = 0
        d2_a_d_sx2 = 0
        d2_a_d_sy2 = 0
        d2_a_d_sx_sy = 0
        cost2 = 0  # cost2[0,0]
        ch = c.conj()
        # compute the first and second derivative with respect to sx and sy first
        for i in range(4):
            for j in range(i + 1, 4):
                cr = np.real((c[i] * ch[j]))[0]
                ci = np.imag((c[i] * ch[j]))[0]
                dx = self.x_loc[j] - self.x_loc[i]
                dy = self.y_loc[j] - self.y_loc[i]
                dcr = cr * np.sin(2 * pi * (dx * sx + dy * sy))
                dci = -ci * np.cos(2 * pi * (dx * sx + dy * sy))
                d_a_d_sx += 2.0 * (-dcr * dx + dci * dx) * psi
                d_a_d_sy += 2.0 * (-dcr * dy + dci * dy) * psi
                d2cr = cr * np.cos(2 * pi * (dx * sx + dy * sy))
                d2ci = -ci * np.sin(2 * pi * (dx * sx + dy * sy))
                d2_a_d_sx2 -= 2.0 * (d2cr * dx * dx + d2ci * dx * dx) * psi * psi
                d2_a_d_sy2 -= 2.0 * (d2cr * dy * dy + d2ci * dy * dy) * psi * psi
                d2_a_d_sx_sy -= 2.0 * (d2cr * dx * dy + d2ci * dx * dy) * psi * psi
                # make the gradient vector for sx and sy
        gs = np.array([d_a_d_sx, d_a_d_sy])

        # convert to gradient vector wrt to phi and theta
        d_sx_d_az = -np.sin(evr) * np.sin(azr)
        d_sx_d_ev = np.cos(evr) * np.cos(azr)
        d_sy_d_az = np.sin(evr) * np.cos(azr)
        d_sy_d_ev = np.cos(evr) * np.sin(azr)
        # Compute the gradient vector wrt bearing angles
        jg = np.array([[d_sx_d_az, d_sy_d_az], [d_sx_d_ev, d_sy_d_ev]])
        gb = np.dot(jg, gs)

        # convert to hassian matrix wrt to phi and theta

        d2_sx_d_az2 = -np.sin(evr) * np.cos(azr)
        d2_sx_d_ev2 = -np.sin(evr) * np.cos(azr)
        d2_sy_d_az2 = -np.sin(evr) * np.sin(azr)
        d2_sy_d_ev2 = -np.sin(evr) * np.sin(azr)
        d2_sx_d_az_ev = -np.cos(evr) * np.sin(azr)
        d2_sy_d_az_ev = -np.cos(evr) * np.cos(azr)

        hs = np.array([d2_a_d_sx2, d2_a_d_sx_sy, d2_a_d_sy2, d_a_d_sx, d_a_d_sy])
        jh = np.array([[d_sx_d_az ** 2, d_sx_d_az * d_sy_d_az, d_sy_d_az ** 2, d2_sx_d_az2, d2_sy_d_az2] \
                          , [d_sx_d_az * d_sx_d_ev, d_sx_d_az * d_sy_d_ev, d_sy_d_az * d_sy_d_ev, d2_sx_d_az_ev,
                             d2_sy_d_az_ev] \
                          , [d_sx_d_ev ** 2, d_sx_d_ev * d_sy_d_ev, d_sy_d_ev ** 2, d2_sx_d_ev2, d2_sy_d_ev2]])
        hb = np.dot(jh, hs)
        Hb = np.array([[hb[0], hb[1]], [hb[1], hb[2]]])
        # find the inverse hassian matrix
        Bb = np.array([[hb[2], -hb[1]], [-hb[1], hb[0]]])
        Bb = Bb / (hb[2] * hb[0] - hb[1] ** 2)
        return gb, Bb


def computeCost(bearing, x_loc, y_loc, c):
    phi = bearing[0]
    theta = bearing[1]
    sx = np.cos(phi) * np.abs(np.sin(theta))
    sy = np.sin(phi) * np.abs(np.sin(theta))
    A = np.array([2.0 * pi * x_loc, 2.0 * pi * y_loc])
    phase = np.dot(np.array([sx, sy]), A)
    e = np.exp(1j * phase)
    cost = np.dot(np.conj(e), c)
    cost = -np.abs(cost)
    return cost


def gCost(bearing, x_loc, y_loc, c):
    phi = bearing[0]
    theta = bearing[1]
    sx = np.cos(phi) * np.sin(theta)
    sy = np.sin(phi) * np.sin(theta)
    psi = 2 * pi
    d_a_d_sx = 0
    d_a_d_sy = 0

    ch = c.conj()
    # compute the first and second derivative with respect to sx and sy first
    for i in range(4):
        for j in range(i + 1, 4):
            cr = np.real((c[i] * ch[j]))[0]
            ci = np.imag((c[i] * ch[j]))[0]
            dx = x_loc[j] - x_loc[i]
            dy = y_loc[j] - y_loc[i]
            dcr = cr * np.sin(2 * pi * (dx * sx + dy * sy))
            dci = -ci * np.cos(2 * pi * (dx * sx + dy * sy))
            d_a_d_sx += 2.0 * (-dcr * dx + dci * dx) * psi
            d_a_d_sy += 2.0 * (-dcr * dy + dci * dy) * psi

            # make the gradient vector for sx and sy
    gs = -np.array([d_a_d_sx, d_a_d_sy])
    return gs