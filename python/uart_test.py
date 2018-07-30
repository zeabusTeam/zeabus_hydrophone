import serial
import struct
import numpy as np
import pickle
import scipy.optimize as opt
import matplotlib.pyplot as plt
import  sys

pi = np.pi
h_lp = np.array([
  0.005150987130580312,
  0.00032201977331465005,
  0.0003300553656073725,
  0.0003368213256267493,
  0.00034225587650410874,
  0.00034629730818868965,
  0.0003488074768436787,
  0.0003498463485825652,
  0.0003491470198934413,
  0.00034685854842000474,
  0.00034280198357090886,
  0.00033687087066507695,
  0.00032903756216977033,
  0.0003192084060491991,
  0.0003073522552177227,
  0.0002933529169101153,
  0.00027727059570424085,
  0.00025908403428408786,
  0.00023878668746133715,
  0.00021628818856010473,
  0.00019146410526233462,
  0.00016433546341496145,
  0.00013478907340344065,
  0.00010302547316320314,
  0.00006911458664063273,
  0.00003303264445911425,
  -0.00000558081945129341,
  -0.000046912141894666814,
  -0.00008946800230292883,
  -0.00013498443611970512,
  -0.00018232867515734444,
  -0.00023183996156179792,
  -0.0002834120033413227,
  -0.0003369318394478346,
  -0.0003925103686517555,
  -0.0004496473551511366,
  -0.0005088233206230476,
  -0.0005695099376961756,
  -0.0006316717793284571,
  -0.0006953658687856575,
  -0.0007604397454989755,
  -0.0008267251125422124,
  -0.0008939667247958021,
  -0.0009621330950966571,
  -0.0010310546672426797,
  -0.0011006125044038262,
  -0.0011706260543173715,
  -0.0012408660288898401,
  -0.0013111481021091623,
  -0.0013811982730127965,
  -0.0014509445917370368,
  -0.0015201823214797197,
  -0.001588697201972508,
  -0.0016561450234011885,
  -0.0017223293312073925,
  -0.0017872635669828891,
  -0.0018503070734731746,
  -0.0019116123174281784,
  -0.0019707557230934,
  -0.002027582280652749,
  -0.0020818632580194827,
  -0.0021330160537846162,
  -0.002182219922646962,
  -0.0022262581406012004,
  -0.0022680623878699453,
  -0.0023063209013565755,
  -0.0023402755168712417,
  -0.002369783720906355,
  -0.002394797296742907,
  -0.002415316586551701,
  -0.002430980034995988,
  -0.0024415900638707047,
  -0.002446746451605508,
  -0.002446130341043479,
  -0.0024395242768350425,
  -0.002426712291346705,
  -0.0024075641588717474,
  -0.0023818341442113484,
  -0.0023494216531001824,
  -0.0023101801238685693,
  -0.0022640438156178258,
  -0.0022109104466967997,
  -0.0021507075506010096,
  -0.0020835823817086717,
  -0.002009309969716918,
  -0.0019278542487133688,
  -0.0018387179018739019,
  -0.0017410355048097519,
  -0.0016330785051853897,
  -0.0015113337663093386,
  -0.001399290409789753,
  -0.0012663858339373379,
  -0.001128372746529656,
  -0.000982368636239395,
  -0.0008283590064861899,
  -0.0006664187036563553,
  -0.0004964621572175258,
  -0.00031876143896661786,
  -0.00013309721033565448,
  0.00006023668240615011,
  0.0002611369838274253,
  0.00046952995042140374,
  0.0006852099962060203,
  0.0009080096526005543,
  0.001137689298161699,
  0.0013741855051945247,
  0.0016172905481875348,
  0.001866803889740917,
  0.002122434901704569,
  0.0023838775201702315,
  0.0026509166051296336,
  0.002923211392263573,
  0.0032006672332138453,
  0.003482960082789358,
  0.003769689026924891,
  0.004060283661564631,
  0.0043545018034862396,
  0.0046527072043154125,
  0.004953331597229562,
  0.005256941465830813,
  0.0055627026549698025,
  0.005870324434704425,
  0.006179419877390082,
  0.0064894237328267206,
  0.006800374542368917,
  0.007111086436089033,
  0.007421893502289726,
  0.007732072256024955,
  0.008041003300046392,
  0.008348367013530216,
  0.008653802821965569,
  0.00895695756554074,
  0.009257231692653408,
  0.009554222754477027,
  0.009847448507345601,
  0.010136504916305923,
  0.010421015456913556,
  0.010700545534941944,
  0.010974710442411377,
  0.011242952543446627,
  0.011504893602240206,
  0.011760140866493398,
  0.012008384228926703,
  0.01224916857469195,
  0.012482005532097485,
  0.012706827181067932,
  0.012922919045718333,
  0.013130149644458907,
  0.013328085713214923,
  0.013516459098073096,
  0.013695218742453885,
  0.013862199011727873,
  0.014022869460062181,
  0.014168956789514485,
  0.01430465959411623,
  0.014430147787239469,
  0.014544738942497535,
  0.014647843486451834,
  0.014738993363103315,
  0.014818159342783093,
  0.014885136398156912,
  0.0149400285279587,
  0.014982814915978852,
  0.015013417116567689,
  0.015031806801480694,
  0.015037917226177642,
  0.015031806801480694,
  0.015013417116567689,
  0.014982814915978852,
  0.0149400285279587,
  0.014885136398156912,
  0.014818159342783093,
  0.014738993363103315,
  0.014647843486451834,
  0.014544738942497535,
  0.014430147787239469,
  0.01430465959411623,
  0.014168956789514485,
  0.014022869460062181,
  0.013862199011727873,
  0.013695218742453885,
  0.013516459098073096,
  0.013328085713214923,
  0.013130149644458907,
  0.012922919045718333,
  0.012706827181067932,
  0.012482005532097485,
  0.01224916857469195,
  0.012008384228926703,
  0.011760140866493398,
  0.011504893602240206,
  0.011242952543446627,
  0.010974710442411377,
  0.010700545534941944,
  0.010421015456913556,
  0.010136504916305923,
  0.009847448507345601,
  0.009554222754477027,
  0.009257231692653408,
  0.00895695756554074,
  0.008653802821965569,
  0.008348367013530216,
  0.008041003300046392,
  0.007732072256024955,
  0.007421893502289726,
  0.007111086436089033,
  0.006800374542368917,
  0.0064894237328267206,
  0.006179419877390082,
  0.005870324434704425,
  0.0055627026549698025,
  0.005256941465830813,
  0.004953331597229562,
  0.0046527072043154125,
  0.0043545018034862396,
  0.004060283661564631,
  0.003769689026924891,
  0.003482960082789358,
  0.0032006672332138453,
  0.002923211392263573,
  0.0026509166051296336,
  0.0023838775201702315,
  0.002122434901704569,
  0.001866803889740917,
  0.0016172905481875348,
  0.0013741855051945247,
  0.001137689298161699,
  0.0009080096526005543,
  0.0006852099962060203,
  0.00046952995042140374,
  0.0002611369838274253,
  0.00006023668240615011,
  -0.00013309721033565448,
  -0.00031876143896661786,
  -0.0004964621572175258,
  -0.0006664187036563553,
  -0.0008283590064861899,
  -0.000982368636239395,
  -0.001128372746529656,
  -0.0012663858339373379,
  -0.001399290409789753,
  -0.0015113337663093386,
  -0.0016330785051853897,
  -0.0017410355048097519,
  -0.0018387179018739019,
  -0.0019278542487133688,
  -0.002009309969716918,
  -0.0020835823817086717,
  -0.0021507075506010096,
  -0.0022109104466967997,
  -0.0022640438156178258,
  -0.0023101801238685693,
  -0.0023494216531001824,
  -0.0023818341442113484,
  -0.0024075641588717474,
  -0.002426712291346705,
  -0.0024395242768350425,
  -0.002446130341043479,
  -0.002446746451605508,
  -0.0024415900638707047,
  -0.002430980034995988,
  -0.002415316586551701,
  -0.002394797296742907,
  -0.002369783720906355,
  -0.0023402755168712417,
  -0.0023063209013565755,
  -0.0022680623878699453,
  -0.0022262581406012004,
  -0.002182219922646962,
  -0.0021330160537846162,
  -0.0020818632580194827,
  -0.002027582280652749,
  -0.0019707557230934,
  -0.0019116123174281784,
  -0.0018503070734731746,
  -0.0017872635669828891,
  -0.0017223293312073925,
  -0.0016561450234011885,
  -0.001588697201972508,
  -0.0015201823214797197,
  -0.0014509445917370368,
  -0.0013811982730127965,
  -0.0013111481021091623,
  -0.0012408660288898401,
  -0.0011706260543173715,
  -0.0011006125044038262,
  -0.0010310546672426797,
  -0.0009621330950966571,
  -0.0008939667247958021,
  -0.0008267251125422124,
  -0.0007604397454989755,
  -0.0006953658687856575,
  -0.0006316717793284571,
  -0.0005695099376961756,
  -0.0005088233206230476,
  -0.0004496473551511366,
  -0.0003925103686517555,
  -0.0003369318394478346,
  -0.0002834120033413227,
  -0.00023183996156179792,
  -0.00018232867515734444,
  -0.00013498443611970512,
  -0.00008946800230292883,
  -0.000046912141894666814,
  -0.00000558081945129341,
  0.00003303264445911425,
  0.00006911458664063273,
  0.00010302547316320314,
  0.00013478907340344065,
  0.00016433546341496145,
  0.00019146410526233462,
  0.00021628818856010473,
  0.00023878668746133715,
  0.00025908403428408786,
  0.00027727059570424085,
  0.0002933529169101153,
  0.0003073522552177227,
  0.0003192084060491991,
  0.00032903756216977033,
  0.00033687087066507695,
  0.00034280198357090886,
  0.00034685854842000474,
  0.0003491470198934413,
  0.0003498463485825652,
  0.0003488074768436787,
  0.00034629730818868965,
  0.00034225587650410874,
  0.0003368213256267493,
  0.0003300553656073725,
  0.00032201977331465005,
  0.005150987130580312]
)

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
            #k_best = np.nonzero(Ck2 == Ck2.max())[0][0]
            k_best = np.nonzero(Ck2 == Ck2.max())
            #print(k_best)
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

if __name__ == "__main__":

    ########################## setting parameter #################################

    Sampling_rate = 191930
    Frequency = 30000
    SoundSpeed = 1500
    FrontThreshold = 0.3
    PowerThreshold = 0.02
    DelayObserve = 2000

    ##############################################################################

    s = serial.Serial('com4',460800,bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)

    res = []
    res.append(61)
    res.append(61)
    res.append(61)
    res.append(61)
    tmp = struct.pack('I', Frequency)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('I', SoundSpeed)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('f', FrontThreshold)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('f', PowerThreshold)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])
    tmp = struct.pack('I', DelayObserve)
    res.append(tmp[0])
    res.append(tmp[1])
    res.append(tmp[2])
    res.append(tmp[3])  

    s.write(res)
    s.flush()
    N = 2048

    
    uart_sum = 0;

    count = 0
    fig, axis = plt.subplots(1,1)
    plot_out = None
    while True:
        while True:
            x = s.read(1)
            uart_sum += 1
            if x == b'\xff':
                # print(x)
                x = s.read(1)
                uart_sum += 1
                # print(x)
                count +=1
                if x == b'\xff':
                    x = s.read(14)
                    uart_sum += 14
                    # print(x)
                    count = 0
                    break

        array = np.arange(N * 4).reshape(4, N)
        sig = np.zeros_like(array, np.float32)
        seq = struct.unpack('<H', x[0:2])
        freq = struct.unpack('<I', x[2:6])
        time_between_pulse = struct.unpack('<I', x[6:10])
        processing_time = struct.unpack('<I', x[10:14])

        print ("seq : %d" %seq)
        print ("freq : %d" %freq)
        print ("time_between_pulse : %d" %time_between_pulse)
        print ("processing_time : %d" %processing_time)

        x = s.read(1)
        x = s.read(1)
        uart_sum += 2
    
        x = s.read(N * 4 * 2)
        uart_sum += (N * 4 * 2)

        start_id = 0

        a = start_id
        for i in range(0, N):
            (sig[0,i],) = struct.unpack('@f', x[(a + (i * 4)) :(a + (i * 4) + 4)])
            start_id = start_id + 4
        
        a = start_id
        for i in range(0, N):
            (sig[1,i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
            start_id = start_id + 4

        x = s.read(1)
        x = s.read(1)
        uart_sum += 2

        x = s.read(N * 4 * 2)
        uart_sum += (N * 4 * 2)

        start_id = 0

        a = start_id
        for i in range(0, N):
            (sig[2,i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
            start_id = start_id + 4

        a = start_id
        for i in range(0, N):
            (sig[3,i],) = struct.unpack('@f', x[a + (i * 4) :a + (i * 4) + 4])
            start_id = start_id + 4

        x = s.read(1)
        x = s.read(1)
        uart_sum += 2

        print("uartsum :")
        print(uart_sum)
        # print(sig)
        sig = sig[:, 800:1500]
        t = np.arange(sig.shape[1])
        if plot_out is None:
            plot_out = axis.plot(t, sig[0,:] , t, sig[1,:], t, sig[2,:], t, sig[3,:])
        else:
            for tt in range(4):
                plot_out[tt].set_data(t, sig[tt,:])



        axis.legend(["CH1", "CH2", "CH3", "CH4"])
        fig.canvas.draw()
        plt.show(False)
        plt.pause(0.01)



        complex_baseband = demodulation(sig,Sampling_rate,Frequency)




    # f = open('store.pckl', 'rb')
    # sig = pickle.load(f)
    # f.close()

        # print(sig)
        # t = np.arange(sig.shape[1])
        # plt.plot(t, np.angle(sig[0,:]) * 180 / pi,t, np.angle(sig[1,:]) * 180 / pi,t, np.angle(sig[2,:]) * 180 / pi,
        # t, np.angle(sig[3,:]) * 180 / pi)
        # plt.legend(["CH1", "CH2", "CH3", "CH4"])
        

        

        br = bearingEstimator(complex_baseband, np.array([[0,0],[-20,0],[-20,-20],[0,-20]]),
                              Frequency/1000.0, Sampling_rate/1000.0)

        br.delay_time_estimator(1)
        az, ev, az_init, ev_init = br.bearingEstimatorForT0(1, fine_tune=True)

        print("The estimated arrival angle:")
        print("Azimuth: %f, Elevation: %f" % (az, ev))

        # f = open('store.pckl', 'rb')
        # obj = pickle.load(f)
        # f.close()
