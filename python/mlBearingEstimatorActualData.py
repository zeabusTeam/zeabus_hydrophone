__author__ = 'Teerasit Kasetkasem'
import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as sgn
import time
import csv
import scipy.optimize as opt
import itertools as itl

# hlp = np.array([  -0.0008453470597592304,
#   -0.002712473014466144,
#   -0.005788634958659003,
#   -0.009171023634709823,
#   -0.010705955411809303,
#   -0.007218961126548628,
#   0.004526073044614337,
#   0.02637759604805089,
#   0.05743262361200088,
#   0.09345642810292086,
#   0.12755817815137688,
#   0.15206931577086633,
#   0.16099477910402013,
#   0.15206931577086633,
#   0.12755817815137688,
#   0.09345642810292086,
#   0.05743262361200088,
#   0.026377596048050886,
#   0.004526073044614337,
#   -0.007218961126548632,
#   -0.010705955411809303,
#   -0.009171023634709823,
#   -0.0057886349586590115,
#   -0.0027124730144661396,
#   -0.0008453470597592304
# ])


hlp = np.array([0.0002981375093294158,
                0.000021751360521773363,
                0.00002218514169008316,
                0.000022289041581569117,
                0.000022151087855930208,
                0.000021683317591081464,
                0.000020900901395632547,
                0.00001975049102899219,
                0.0000182228155500449,
                0.000016280161515325108,
                0.000013909084235738476,
                0.000011077393517953303,
                0.000007765358716078791,
                0.000003939101669008743,
                -4.268656719682741e-7,
                -0.00000536675629307538,
                -0.000010906947508682835,
                -0.000017079042528478772,
                -0.000023908535035259694,
                -0.00003142570638031738,
                -0.00003965723672950811,
                -0.000048634413754245176,
                -0.00005838571051448606,
                -0.00006894256049361317,
                -0.00008033293509925241,
                -0.00009258610971966641,
                -0.00010572784624855865,
                -0.00011978483739514448,
                -0.00013478103924487465,
                -0.00015074135385919897,
                -0.0001676882962262674,
                -0.00018564472200398774,
                -0.00020463080063822415,
                -0.00022466627644154874,
                -0.000245768065825027,
                -0.0002679523287712985,
                -0.00029123253602151135,
                -0.00031562114163477724,
                -0.00034112781057756393,
                -0.0003677606551175233,
                -0.0003955247113085383,
                -0.0004244230198707231,
                -0.00045445552320297534,
                -0.00048562005706523657,
                -0.0005179115045120139,
                -0.0005513224923748941,
                -0.000585842604349562,
                -0.0006214587595920108,
                -0.0006581545767371102,
                -0.0006959106123280835,
                -0.0007347039875828789,
                -0.0007745085059533206,
                -0.0008152944565438914,
                -0.0008570285191230238,
                -0.0008996737143166818,
                -0.000943189165247126,
                -0.0009875303169975453,
                -0.0010326486382071932,
                -0.0010784920960860613,
                -0.001125004666636049,
                -0.0011721269147088713,
                -0.0012197952126868962,
                -0.0012679424826048038,
                -0.0013164972695996092,
                -0.0013653848431865972,
                -0.001414526188184292,
                -0.0014638394112906257,
                -0.0015132384289276025,
                -0.001562634518738189,
                -0.0016119346170348498,
                -0.0016610431855737398,
                -0.0017098603185850898,
                -0.0017582841622121794,
                -0.001806208749662071,
                -0.001853526758803577,
                -0.0019001265953264973,
                -0.0019458952804219723,
                -0.001990714728300413,
                -0.00203446531824382,
                -0.0020770219052245998,
                -0.0021182587953047197,
                -0.002158045443877665,
                -0.0021962526311088406,
                -0.002232746807024823,
                -0.0022673970381133055,
                -0.0023000673869528377,
                -0.0023306255258699056,
                -0.002358933511352357,
                -0.0023848595950174706,
                -0.002408266617004949,
                -0.0024290271974950245,
                -0.0024470064667687272,
                -0.002462080803228682,
                -0.002474111361275305,
                -0.0024829712172144015,
                -0.002488506956802496,
                -0.002490586755608968,
                -0.002489039564595963,
                -0.002483750373460012,
                -0.0024745289051154836,
                -0.0024613924735581642,
                -0.002444166098259973,
                -0.0024234083741673214,
                -0.0023973336538153553,
                -0.002367382990944203,
                -0.002332775550598445,
                -0.0022935708724770728,
                -0.002249632102306348,
                -0.002200901451391363,
                -0.002147265245797821,
                -0.0020886527099022514,
                -0.0020249733345769154,
                -0.001956167302704618,
                -0.0018821663085028502,
                -0.0018029226412545653,
                -0.0017183825266395528,
                -0.0016285064912293205,
                -0.0015332521133490445,
                -0.0014325904368774638,
                -0.001326494228225003,
                -0.001214950395175906,
                -0.001097950188152966,
                -0.0009754977725556065,
                -0.0008476016892006078,
                -0.0007142814592628634,
                -0.0005755610856602944,
                -0.00043147505393198405,
                -0.00028206358680730494,
                -0.0001273777814719057,
                0.00003252446960321616,
                0.00019757458018066737,
                0.0003676969841558121,
                0.0005428059901532537,
                0.0007228087793387668,
                0.0009076025631811848,
                0.0010970769675889768,
                0.001291111695741579,
                0.0014895787457393647,
                0.001692340727120134,
                0.0018992529101357785,
                0.0021101618579559616,
                0.0023249070171551204,
                0.0025433194311520776,
                0.0027652229468339883,
                0.002990433207341015,
                0.0032187587744294255,
                0.0034500005432518644,
                0.0036839527908533545,
                0.00392040284979644,
                0.00415913192951608,
                0.00439991495086131,
                0.00464252118390118,
                0.0048867143347465876,
                0.005132253079323992,
                0.005378891373880105,
                0.005626378771174101,
                0.005874460818479104,
                0.006122879097464541,
                0.0063713717807330275,
                0.006619673557156319,
                0.006867516521031803,
                0.00711463004713958,
                0.007360741958723352,
                0.0076055781891371365,
                0.007848864107599772,
                0.008090323923828772,
                0.008329682286149226,
                0.008566663547123758,
                0.008800993719902747,
                0.009032399471653078,
                0.00926061022202947,
                0.00948535656510265,
                0.009706372450427946,
                0.009923393149707417,
                0.010136157966142109,
                0.01034440811293412,
                0.010547890253437716,
                0.01074635408803506,
                0.010939556386058558,
                0.01112725765222938,
                0.011309226473576201,
                0.01148523522268713,
                0.011655065364115851,
                0.011818502536326062,
                0.011975343301284221,
                0.012125389000956192,
                0.012268453509597928,
                0.01240435458475545,
                0.012532922798310357,
                0.012653990290912808,
                0.012767403118517665,
                0.012873008062842547,
                0.012970670825787364,
                0.013060258769574567,
                0.013141665413409769,
                0.013214782711713922,
                0.013279533828930812,
                0.013335826492307058,
                0.013383606500935239,
                0.013422776666472219,
                0.013453310664386828,
                0.01347506562565219,
                0.01348823922450877,
                0.013492455190622095,
                0.01348823922450877,
                0.01347506562565219,
                0.013453310664386828,
                0.013422776666472219,
                0.013383606500935239,
                0.013335826492307058,
                0.013279533828930812,
                0.013214782711713922,
                0.013141665413409769,
                0.013060258769574567,
                0.012970670825787364,
                0.012873008062842547,
                0.012767403118517665,
                0.012653990290912808,
                0.012532922798310357,
                0.01240435458475545,
                0.012268453509597928,
                0.012125389000956192,
                0.011975343301284221,
                0.011818502536326062,
                0.011655065364115851,
                0.01148523522268713,
                0.011309226473576201,
                0.01112725765222938,
                0.010939556386058558,
                0.01074635408803506,
                0.010547890253437716,
                0.01034440811293412,
                0.010136157966142109,
                0.009923393149707417,
                0.009706372450427946,
                0.00948535656510265,
                0.00926061022202947,
                0.009032399471653078,
                0.008800993719902747,
                0.008566663547123758,
                0.008329682286149226,
                0.008090323923828772,
                0.00784886410759977,
                0.0076055781891371365,
                0.007360741958723352,
                0.00711463004713958,
                0.006867516521031804,
                0.006619673557156319,
                0.0063713717807330275,
                0.006122879097464541,
                0.005874460818479104,
                0.0056263787711741,
                0.005378891373880105,
                0.005132253079323992,
                0.0048867143347465876,
                0.00464252118390118,
                0.00439991495086131,
                0.00415913192951608,
                0.00392040284979644,
                0.0036839527908533545,
                0.0034500005432518644,
                0.0032187587744294255,
                0.002990433207341015,
                0.0027652229468339883,
                0.0025433194311520776,
                0.0023249070171551204,
                0.0021101618579559616,
                0.0018992529101357785,
                0.001692340727120134,
                0.0014895787457393647,
                0.001291111695741579,
                0.0010970769675889768,
                0.0009076025631811848,
                0.0007228087793387668,
                0.0005428059901532538,
                0.0003676969841558121,
                0.00019757458018066737,
                0.00003252446960321616,
                -0.0001273777814719057,
                -0.00028206358680730494,
                -0.00043147505393198405,
                -0.000575561085660295,
                -0.0007142814592628634,
                -0.0008476016892006078,
                -0.0009754977725556065,
                -0.001097950188152966,
                -0.001214950395175906,
                -0.001326494228225003,
                -0.0014325904368774638,
                -0.0015332521133490445,
                -0.0016285064912293205,
                -0.0017183825266395528,
                -0.0018029226412545653,
                -0.0018821663085028502,
                -0.001956167302704618,
                -0.0020249733345769154,
                -0.0020886527099022514,
                -0.002147265245797821,
                -0.002200901451391363,
                -0.002249632102306348,
                -0.0022935708724770728,
                -0.002332775550598445,
                -0.002367382990944203,
                -0.0023973336538153553,
                -0.0024234083741673214,
                -0.002444166098259973,
                -0.0024613924735581642,
                -0.0024745289051154836,
                -0.002483750373460012,
                -0.002489039564595963,
                -0.002490586755608968,
                -0.002488506956802496,
                -0.0024829712172144015,
                -0.002474111361275305,
                -0.002462080803228682,
                -0.0024470064667687272,
                -0.0024290271974950245,
                -0.002408266617004949,
                -0.0023848595950174715,
                -0.002358933511352356,
                -0.0023306255258699056,
                -0.002300067386952838,
                -0.0022673970381133055,
                -0.002232746807024823,
                -0.0021962526311088406,
                -0.002158045443877665,
                -0.0021182587953047197,
                -0.0020770219052245998,
                -0.00203446531824382,
                -0.0019907147283004132,
                -0.001945895280421972,
                -0.0019001265953264973,
                -0.001853526758803577,
                -0.001806208749662071,
                -0.0017582841622121794,
                -0.0017098603185850898,
                -0.0016610431855737398,
                -0.0016119346170348498,
                -0.001562634518738189,
                -0.0015132384289276025,
                -0.0014638394112906257,
                -0.001414526188184292,
                -0.0013653848431865972,
                -0.0013164972695996087,
                -0.0012679424826048038,
                -0.0012197952126868962,
                -0.0011721269147088713,
                -0.001125004666636049,
                -0.0010784920960860613,
                -0.0010326486382071932,
                -0.0009875303169975453,
                -0.0009431891652471258,
                -0.0008996737143166818,
                -0.0008570285191230238,
                -0.0008152944565438914,
                -0.0007745085059533206,
                -0.0007347039875828789,
                -0.0006959106123280835,
                -0.0006581545767371102,
                -0.0006214587595920114,
                -0.000585842604349562,
                -0.0005513224923748941,
                -0.0005179115045120139,
                -0.00048562005706523657,
                -0.0004544555232029748,
                -0.0004244230198707231,
                -0.0003955247113085383,
                -0.00036776065511752323,
                -0.0003411278105775634,
                -0.00031562114163477724,
                -0.00029123253602151135,
                -0.0002679523287712985,
                -0.000245768065825027,
                -0.00022466627644154874,
                -0.00020463080063822415,
                -0.00018564472200398774,
                -0.0001676882962262674,
                -0.00015074135385919897,
                -0.00013478103924487465,
                -0.00011978483739514448,
                -0.00010572784624855865,
                -0.00009258610971966641,
                -0.00008033293509925187,
                -0.00006894256049361317,
                -0.000058385710514484966,
                -0.000048634413754245725,
                -0.000039657236729508104,
                -0.00003142570638031738,
                -0.000023908535035259694,
                -0.000017079042528478772,
                -0.000010906947508682832,
                -0.00000536675629307538,
                -4.2686567196800135e-7,
                0.000003939101669008607,
                0.000007765358716078655,
                0.000011077393517952757,
                0.000013909084235738476,
                0.000016280161515325098,
                0.00001822281555004491,
                0.00001975049102899219,
                0.00002090090139563254,
                0.000021683317591081464,
                0.000022151087855930208,
                0.000022289041581569117,
                0.00002218514169008316,
                0.000021751360521773363,
                0.0002981375093294157
                ])

hlp = np.array([
    0.00019879010498615907,
    0.00022767092201437183,
    0.00025531297065362334,
    0.0002807488034690767,
    0.00030292728623379316,
    0.00032068355810150776,
    0.0003326983139099703,
    0.0003376460852589169,
    0.0003341933695865011,
    0.00032091548182295145,
    0.000296364539390445,
    0.000259263944358662,
    0.00020833024331851343,
    0.00014217611865575787,
    0.000059953547475915676,
    -0.000039470701644621466,
    -0.00015669713367315324,
    -0.0002922990664530668,
    -0.0004464946086915844,
    -0.000619304397528378,
    -0.0008103639470064903,
    -0.0010190058527831626,
    -0.0012441505215466334,
    -0.0014843683522803351,
    -0.0017377808029476643,
    -0.0020021465480106215,
    -0.0022748378647111205,
    -0.0025527693576020624,
    -0.0028325328007029393,
    -0.0031102537798806855,
    -0.003381755263268949,
    -0.0036424503626797805,
    -0.0038875404279695115,
    -0.00411189352951525,
    -0.004310296297175892,
    -0.0044772105191336255,
    -0.004607233224198584,
    -0.00469468844377201,
    -0.004734075974129997,
    -0.004720012262095053,
    -0.004647233657207179,
    -0.0045108127678204785,
    -0.004306182522151814,
    -0.0040291501121243415,
    -0.003675964090637525,
    -0.003243486229290978,
    -0.0027291478897309915,
    -0.002131306629547152,
    -0.0014481165371384246,
    -0.0006811364656148641,
    0.00017174625451366992,
    0.0011072473186550713,
    0.002123252706000729,
    0.0032172284812014293,
    0.004385081043245875,
    0.005621536004483763,
    0.0069206867969490845,
    0.008275955199116843,
    0.00967993286022986,
    0.011124518170530928,
    0.012600984467765383,
    0.014099690637281328,
    0.015610374102465277,
    0.01712319800721637,
    0.01862698495772486,
    0.020111229971570197,
    0.02156478705195722,
    0.02297668061881249,
    0.024335930556454173,
    0.025631855645659486,
    0.026854092299222407,
    0.027992783062529045,
    0.029038665941885658,
    0.029983193774586546,
    0.0308185265267006,
    0.03153769063955536,
    0.032134669991468245,
    0.03260433072397987,
    0.032942730497619886,
    0.03314692061051216,
    0.033215192546999395,
    0.03314692061051216,
    0.032942730497619886,
    0.03260433072397987,
    0.032134669991468245,
    0.03153769063955536,
    0.0308185265267006,
    0.029983193774586546,
    0.029038665941885658,
    0.027992783062529045,
    0.026854092299222407,
    0.025631855645659486,
    0.024335930556454177,
    0.02297668061881249,
    0.02156478705195722,
    0.020111229971570197,
    0.01862698495772486,
    0.01712319800721637,
    0.015610374102465277,
    0.014099690637281328,
    0.012600984467765383,
    0.011124518170530928,
    0.00967993286022986,
    0.008275955199116843,
    0.0069206867969490845,
    0.005621536004483763,
    0.004385081043245875,
    0.0032172284812014293,
    0.002123252706000729,
    0.0011072473186550713,
    0.00017174625451366992,
    -0.0006811364656148641,
    -0.0014481165371384246,
    -0.002131306629547152,
    -0.00272914788973099,
    -0.003243486229290978,
    -0.003675964090637525,
    -0.0040291501121243415,
    -0.004306182522151814,
    -0.0045108127678204785,
    -0.004647233657207179,
    -0.004720012262095053,
    -0.004734075974129997,
    -0.004694688443772011,
    -0.004607233224198584,
    -0.0044772105191336255,
    -0.004310296297175892,
    -0.00411189352951525,
    -0.0038875404279695115,
    -0.0036424503626797805,
    -0.003381755263268949,
    -0.0031102537798806855,
    -0.0028325328007029393,
    -0.0025527693576020624,
    -0.0022748378647111205,
    -0.0020021465480106215,
    -0.0017377808029476643,
    -0.0014843683522803351,
    -0.0012441505215466334,
    -0.0010190058527831626,
    -0.0008103639470064903,
    -0.0006193043975283784,
    -0.0004464946086915844,
    -0.0002922990664530668,
    -0.00015669713367315324,
    -0.00003947070164462148,
    0.000059953547475915676,
    0.00014217611865575787,
    0.0002083302433185148,
    0.000259263944358662,
    0.000296364539390445,
    0.00032091548182295145,
    0.0003341933695865011,
    0.0003376460852589169,
    0.0003326983139099703,
    0.0003206835581015091,
    0.00030292728623379316,
    0.000280748803469076,
    0.00025531297065362334,
    0.00022767092201437183,
    0.00019879010498615907,
    0.0005819638815361733
])

pi = np.pi


class source:
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

        num_samples = int(self.ob_time * self.fs)  # determine the number of pulses

        t = np.arange(num_samples).astype("float64") * (self.ob_time / float(num_samples))
        s = self.vp * np.exp(1j * 2 * pi * self.fo * t)  # The generated signal
        n_p = int(self.period * sampling_rate)  # number of samples per period
        n_s = int(self.ts * sampling_rate)
        n_l = int(self.tp * sampling_rate)
        # print n_p, n_s, n_l
        generated_signal = np.zeros_like(s)
        for n in range(n_s, num_samples, n_p):
            generated_signal[n:(n + n_l)] = s[n:(n + n_l)]

        return generated_signal


class multi_array_channel:
    def __init__(self, num_paths, noise_power, sig_freq, max_delay, max_multipath_gain, num_mics=4):
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
        self.noise_mag = 10.0 ** (noise_power / 20)
        self.max_delay = max_delay
        self.max_multipath_gain = 10.0 ** (max_multipath_gain / 20.0)
        self.fs = sig_freq
        self.lamb = 1500. / sig_freq
        self.num_mics = num_mics

        # print self.max_multipath_gain

    def hydrophone_arrangement(self, locs):
        """
        Determine the relative hydrophone locations normalized by wavelength
        :param locs: location of hydrophone in x, y plane
        :return:
        """

        self.x_loc = locs[:, 0] / self.lamb
        self.y_loc = locs[:, 1] / self.lamb
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
        az = pi * az / 180.0
        elv = pi * elv / 180.0
        phase_shift = 2 * pi * (self.x_loc * np.sin(elv) * np.cos(az) + self.y_loc * np.sin(elv) * np.sin(az))
        time_deley = -(phase_shift / (2.0 * pi)) * (self.lamb / 1500.0)
        # print "time delay = ", time_deley
        complex_phase_shift = np.exp(1j * phase_shift)
        complex_phase_shift = np.diag(complex_phase_shift)
        return complex_phase_shift, time_deley

    def generate_received_signal(self, transmitted_signal, sampling_feq, azimuth, elevation, use_phase=True):
        """
        Generate received signals at all hydrophones with multipaths and noises
        :param transmitted_signal:  transmitted signal pulse
        :param sampling_feq: sampling frequency
        :param azimuth: arrival angles of  main path in azimuth direction in degree
        :param elevation:  arrival angles of  main path in elevation direction in degree
        :return: received signal vector
        """

        # determine the phase delay of main pulse
        v, t_delay = self.phase_delay(azimuth, elevation)
        n_samples = transmitted_signal.size
        s = transmitted_signal.reshape((1, n_samples))
        if use_phase:

            # make copies of transmitted signals to match number of hydrophone
            s = s.repeat(self.num_mics, 0)

            # multiply phase delay to the signal
            rec_noiseless_signal = np.dot(v, s)


        else:

            rec_noiseless_signal = np.zeros((self.num_mics, n_samples), np.complex128)
            num_delays = t_delay * sampling_feq
            for h in range(self.num_mics):
                delay = int(np.round((num_delays[h])))
                if delay >= 0:
                    rec_noiseless_signal[h, delay:] = s[0, :-delay]
                else:
                    rec_noiseless_signal[h, :delay] = s[0, -delay:]
        # determine the delay times for all multipaths
        path_delays = np.random.uniform(0, self.max_delay, self.n_paths)
        n_delays = (path_delays * sampling_feq).astype("int32")

        # Randomly determine the gain magnitude and phasefor all multipaths
        gains = np.random.rayleigh(self.max_multipath_gain, self.n_paths)  # use rayleigh for magnitude
        phases = np.random.uniform(0, 2 * pi, self.n_paths)  # uniform for phase
        complex_gains = gains * np.exp(1j * phases)  # multipath gain

        s = s.repeat(self.num_mics, 0)

        n_samples = transmitted_signal.shape[0]
        for p in range(self.n_paths):
            azp = np.random.uniform(-180, 180)  # randomly choose the arrival angles for all multipaths
            elvp = np.random.uniform(0, 90)

            v, t_delays = self.phase_delay(azp, elvp)  # determine the corresponding phase delays


            # determine the noiseless received signal for the given multipath
            reflected_sig = np.zeros_like(s)
            reflected_sig[:, n_delays[p]:] = s[:, :(n_samples - n_delays[p])]
            # print n_delays[p]
            # print v.shape
            # print (complex_gains[p]*reflected_sig).shape
            reflected_sig = np.dot(v, complex_gains[p] * reflected_sig)
            rec_noiseless_signal += reflected_sig  # add it to the received signal

        noise_p = np.random.normal(0, self.noise_mag, (self.num_mics, n_samples))  # add noises
        rec_noiseless_signal += noise_p

        return rec_noiseless_signal


class analogFrontend:
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
        fl = pi * (self.fo - self.bw / 2.0) * 2
        fh = pi * (self.fo + self.bw / 2.0) * 2
        b, a = sgn.butter(self.orders, np.array([fl, fh]), btype="bandpass",
                          analog=True)  # use this one to create filter
        # b2,a2 = sgn.butter(self.orders,np.array([fl/self.fs/np.pi,fh/self.fs/np.pi]),btype="bandpass",analog =False)
        # print a2, b2


        fm = self.fs / 2.0
        f = np.linspace(-fm, fm, self.num_sampples)
        s = 1j * 2 * pi * f
        w, h = sgn.freqs(b, a, 2 * pi * f)
        self.H = h  # Here is the FFT of filter

    def filtering(self, sig):
        """
        filter the received signal
        :param sig: received signal at the hydrophone array
        :return: filtered signal
        """

        (N, n_samples) = sig.shape
        filtered_sig = np.zeros_like(sig, np.complex128)
        H = np.fft.ifftshift(self.H)
        h = np.real(np.fft.ifft(H))
        # h = h[::-1]
        h = h[:100]

        for n in range(N):
            # we use multiplication in frequency domain to filter the received signals.
            s = sig[n, :]
            # S = np.fft.fft(s)
            # S = np.fft.fftshift(S)
            # Y = S*self.H
            # Y = np.fft.ifftshift(Y)
            # y = np.fft.ifft(Y)
            y = np.convolve(s, h, mode="full")

            filtered_sig[n, :] = y[:s.shape[0]]
            # filtered_sig[n, 0:1000] = 0.0
        self.filtered_sig = filtered_sig

    def sampling(self, fs):
        """
        Sampling the received signal at the given frequency
        :param fs: sampling frequency in kHz where fs < self.sampling_freq
        :return: sampled signal
        """
        N = int(self.fs / fs)
        sampled_sig = self.filtered_sig[:, ::N]
        return sampled_sig


class demodulate_module:
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
        self.t_max = float(n_samples) / sampling_rate

    def demoduate(self, t=None):
        """
        Perform demodulation
        :return: demoduated pulses.
        """
        if t is None:
            t = np.arange(self.n_samples).astype("float64") * (self.t_max / float(self.n_samples))

        print "f0 = ", self.fo
        print "fs = ", 1. / (t[2] - t[1])

        carrier = np.exp(1j * 2 * pi * self.fo * t)  # create the sinusoidal signal from the local oscilator.

        ylpf = np.zeros_like(self.sig, np.complex128)

        for n in range(self.n_ants):
            y = np.real(self.sig[n, :]) * carrier  # multiply the received signal with local signal
            # perform lowpass filter with filter hlp given on the top of the file.
            ylpf[n, :] = np.convolve(y, hlp, 'same')

        return ylpf


def pulseDetection(basedBandSignal, pulse_width, sampling_freq):
    """
    Detect the signal pulse
    :param basedBandSignal: demodulated signal
    :param pulse_width: pulse width in ms
    :param sampling_freq: sampling frequency in kHz
    :return: the detected location and the puls
    """

    n_arrays, n_samples = basedBandSignal.shape
    n_per_pulse = int(pulse_width * sampling_freq)
    # determine the signal power
    envelop = np.abs(basedBandSignal) ** 2
    power = envelop.sum(0)

    p_min = 1e10
    h = 0.001
    p = 0
    p_avg = 0.0

    for n in range(50, n_samples):
        p_avg = p_avg * (float(n)) / (float(n + 1)) + power[n] * 1.0 / (float(n + 1))
        # print "p avg", p_avg
        p = power[n]
        p_min = min(p, p_min)
        if (p > (p_avg * 4)) & (p > 0.1e-3):  # #(p_min+h):
            break
    # n = max(0,n-100)
    pulse = basedBandSignal[:, n:(n + n_per_pulse)]
    # print pulse.shape
    return n, pulse


def CFARPulseDetection(basedBandSignal, l, Pf, pulse_width, sampling_freq):
    """
  Using CFAR (constant false alarm rate) approach for pulse detection.
  We will slide a windows of size l to estimate noise variance.
  and use Pf to find an appropriate threshold.
  :param basedBandSignal:
  :param pulse_width:
  :param sampling_freq:
  :return:
  """
    threshold = 28.0  # 28.473#False alarm of 10^-5
    n_arrays, n_samples = basedBandSignal.shape
    power = np.real(basedBandSignal * np.conj(basedBandSignal))
    n_per_pulse = int(pulse_width * sampling_freq)

    h = np.ones((l + 1,), 'float32') / float(l)
    h[-1] = 0.0
    avpower = np.zeros((n_arrays, n_samples - l), 'float32')
    for n in range(n_arrays):
        avpower[n, :] = np.convolve(power[n, :], h, 'valid')
    noise_sigma2 = avpower.mean(0)
    pout = power[:, l:].sum(0) / noise_sigma2
    print "p out max", pout.max()
    possible_pulse_locations = np.nonzero(pout > threshold)[0]
    if len(possible_pulse_locations) > 1:
        diff = possible_pulse_locations[1:] - possible_pulse_locations[:-1]
        # print possible_pulse_locations
        use_ones = (diff > 1000)
        kk = np.nonzero(use_ones)[0]
        beg_pulse_right = np.hstack((possible_pulse_locations[kk], np.array(possible_pulse_locations[-1])))
        beg_pulse_left = np.hstack((np.array(possible_pulse_locations[0]), possible_pulse_locations[kk + 1]))
        kk2 = np.nonzero(beg_pulse_right - beg_pulse_left < n_per_pulse / 10)
        beg_pulse = beg_pulse_left[kk2]
    else:
        beg_pulse = possible_pulse_locations
    # print beg_pulse_right
    # print beg_pulse_left
    # print beg_pulse
    pulses = []
    for id in beg_pulse:
        str = id + l
        pulses.append([str, basedBandSignal[:, str:str + n_per_pulse]])
    return pulses


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

    def delay_time_estimator_sparse_rep(self, down_sampling_rate):
        """

        :param down_sampling_rate:
        :return:
        """
        h = self.pulse[:, ::down_sampling_rate].copy()  # down sampling to reduce storate space
        n_ants, pulse_length = h.shape
        AA = np.ones((pulse_length, pulse_length))
        AA = np.tril(AA)
        for k in range(pulse_length):
            ck1 = np.dot(h[0], AA[k])
            ck2 = np.dot(h[1], AA[k])
            ck3 = np.dot(h[2], AA[k])
            ck4 = np.dot(h[3], AA[k])

    def delay_time_estimator(self, down_sampling_rate):
        """
        Estimate arrival times and number of multiplaths
        :param down_sampling_rate: downsampling rate must be integer>=1
        :return: arrival times
        """
        h = self.pulse[:, ::down_sampling_rate].T.copy()  # down sampling to reduce storate space
        n_ants, pulse_length = h.T.shape
        AA = np.ones((pulse_length, pulse_length))
        AA = np.tril(AA)
        h2 = h.T.copy()
        ckminbest = 0
        AA2 = AA.T.copy()
        for k in range(pulse_length):
            AA2[k] = AA[:, k].T / np.linalg.norm(AA[:, k])

        k_best = 0
        k_min = pulse_length
        print AA2.shape, h2.shape
        erbest = np.linalg.norm(h2)
        print "initial norm: ", erbest
        A_used = None
        k_a = []
        for m in range(15):
            CK = np.dot(AA2, h2.T)
            Ck2 = np.abs(CK).sum(1)
            k_best = np.nonzero(Ck2 == Ck2.max())[0][0]
            # print k_best
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
        # First pulse at t = 0
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
        print 'We found %f paths' % len(tau)
        print "at time  =", tau
        self.tau = tau  # result

    def delay_time_estimator2(self, down_sampling_rate):
        # new time of arrival estimation algorithm
        # It can detect many arriving pulses
        # However, I do not see any performance gain at this points.

        h = self.pulse[:, ::down_sampling_rate].T.copy()  # down sampling to reduce storate space
        n_ants, pulse_length = h.T.shape

        tau = []
        # First pulse at t = 0
        V = np.zeros((pulse_length, 1))
        finding_tau = True
        n_paths = 0
        while finding_tau:
            V = np.zeros((pulse_length, n_paths + 1))
            eout = np.zeros((pulse_length,))
            for t in range(3, pulse_length):
                # shift location of starting pulse in the second column
                V[:, n_paths] = 0
                V[t:, n_paths] = 1
                VH = V.T.conj()
                P = np.real(np.dot(VH, V))
                P = np.linalg.inv(P)
                c1 = np.dot(VH, h)
                # P = np.real(np.dot(np.dot(V,P),VH))

                e2 = np.trace(np.dot(c1.T.conj(), np.dot(P, c1)))  # main objective function
                eout[t] = np.real(e2)
                if ((eout[t - 1] > eout[t - 2]) & (eout[t - 1] > eout[t]) & (t > 3)):  # search for local maxima
                    tau.append(t - 1)  # add the local optima in the list
                    n_paths += 1
                    Vold = V.copy()
                    V = np.zeros((pulse_length, n_paths + 1))
                    V[:, :-1] = Vold
            V_old = V.copy()
            finding_tau = False
            print 'We found %f paths' % len(tau)
            print "at time = ", tau
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
        print "c_power:%f dBm" % (10.0 * np.log10((creal ** 2 + cimg ** 2).sum()) + 30)
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
        print "computed phase of the first path result = ", phase_c * 180 / pi
        print "Check for validity of input phases"
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
                print "Found a more suitable arrangement with new phase = ", phase_diff * 180. / np.pi
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
        print "A = ", (self.A)
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
        print "initial = %f, %f" % (az_t, elv_t)

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


if __name__ == "__main__":

    print "loading a file"
    Case = 6
    # Case can be:
    #  AA: Actual arriving angle azimuth = 90, elevation around 90
    #  BB: Actual arriving angle azimuth = 135, elevation around 90
    #  DD: Actual arriving angle azimuth = 135, elevation around 90
    #  FF: Actual arriving angle azimuth = 180, elevation around 90

    windows = True  # My computer is linux.
    if windows:
        # data_file = r"C:\Users\User\Dropbox\UAV\NewData\NewFile0%sv2.csv"%Case
        data_file = r"C:\Users\Teerasit\Dropbox\UAV\test211058\test82_500ksample_newBatt.csv"
    else:
        data_file = "/home/professor/Dropbox/UAV/NewData/NewFile0%sv2.csv" % Case

    csvfile = open(data_file, 'rb')  # load data from a file
    rder = csv.reader(csvfile, delimiter=",")
    # print rder

    fc = 28.0  # in this problem, the pulse frequency is 27.5 kHz.
    fs = 500


    # t = [] # time
    v1 = []  # Hydrophone 1 voltage
    v2 = []  # Hydrophone 2 voltage
    v3 = []  # Hydrophone 3 voltage
    v4 = []  # Hydrophone 4 voltage
    line = 1
    for c2, c3, c4, c5 in rder:  # read one line at a time
        print line
        line += 1
        # load data from a file
        # t.append(float(c1))
        if (len(c2) > 0) & (len(c3) > 0) & (len(c4) > 0) & (len(c5) > 0):
            v1.append(10 * float(c2))
            v2.append(10 * float(c3))
            v3.append(10 * float(c4))
            v4.append(10 * float(c5))

    # t = np.array(t)*1000.0 # Make time to be millisecond
    # t = t -t.min() # I make time offset to zero.
    # t = t/1.0 # I do not know why I need to divide t by 5
    t = np.arange(len(v1)) / float(fs)
    # it seems that the sampling frequnency is 5 times more than the given information
    # Without the division by 5, the pinger frequecy is 7kHz instead of 35 KHz
    fs = (1. / (t[2] - t[1]))
    print "Sampling frequency : %f KHz" % (1. / (t[2] - t[1]))
    # Change the loaded data into numpy arrays.
    v1 = np.array(v1)
    v2 = np.array(v2)
    v3 = np.array(v3)
    v4 = np.array(v4)
    # remove DC Component
    v1 = v1 - v1.mean()
    v2 = v2 - v2.mean()
    v3 = v3 - v3.mean()
    v4 = v4 - v4.mean()
    print v1.shape
    # Check the Fourier's Spectrum
    # We should have a large peak t 35 KHz/
    # Compute FFT

    V1 = np.fft.fft(v1)
    V1 = np.fft.fftshift(V1)  # Shift so that the zero freq. is in the middle.
    f = (np.arange(v1.shape[0]) - v1.shape[0] / 2).astype('float32')
    f = (f / (t[2] - t[1])) / ((v1.shape[0]))
    # f is between -fm ,fm where fm = fs/2

    plt.figure(1)
    plt.plot(f, np.abs(V1))
    plt.xlim([-fs / 10, fs / 10])
    plt.xticks([-100, -75, -50, -25, 0, 25, 50, 75, 100])
    plt.title("Magnitude of Fourier Spectrum of Hydrophone 1")
    plt.xlabel("frequency (kHz)")
    plt.grid()
    plt.show(block=True)
    # Create a recieved signal vectors
    rec_sig = np.zeros((4, t.shape[0]))
    plt.figure(2)
    rec_sig[0, :] = v1
    rec_sig[1, :] = v2
    rec_sig[2, :] = v3
    rec_sig[3, :] = v4
    pulses = CFARPulseDetection(rec_sig, 50, 1e-4, 4.0, fs)
    for n, pulse in pulses:
        print "Detect a pulse at %d" % n
        for k in range(4):
            plt.subplot(4, 1, k + 1)
            plt.plot(pulse[k, :])
        plt.grid()
        plt.show(block=False)
    # I want to show only the starting of the pulse areas
    # The tricker is set at 10 mv.
    # idx = np.nonzero(v1>0.01)
    # idx = idx[0]
    # idmin = idx.min()
    # tp = t[idmin]
    # plt.plot(t,v1,t,v2,t,v3,t,v4)
    # plt.xlim([t[max(0,idmin-100)], t[max(0,idmin+200)]])
    # v1max =np.abs(v1[max(0,idmin-100):idmin+100]).max()
    # v2max =np.abs(v2[max(0,idmin-100):idmin+100]).max()
    # v3max =np.abs(v3[max(0,idmin-100):idmin+100]).max()
    # v4max =np.abs(v4[max(0,idmin-100):idmin+100]).max()
    # vmax = 1.1*max([v1max, v2max, v3max, v4max])
    # plt.xlabel("time (ms)")
    # plt.ylim([-vmax, vmax])
    # plt.legend(["H1", "H2", "H3", "H4"])
    # plt.title("Received Signal Starting at the Pulse Area.")


    rec = rec_sig  # Received signal vectors
    magr = np.abs(rec).max() * 0.75
    tx = t
    kk = np.arange(rec.shape[1])
    plt.figure(3)
    plt.plot(tx, rec[0, :], tx, rec[1, :], tx, rec[2, :], tx, rec[3, :])
    plt.xlabel("time (ms)")
    plt.title("Received Signal (Entire Pulses")
    plt.legend(["H1", "H2", "H3", "H4"])
    plt.grid()
    plt.show(block=False)

    # Pass received signal into a band pass filter
    # fc = 30 KHz
    # Bandwidth = 20 kHz.
    # Filter order = 2.0
    frontend = analogFrontend(fc, 10.0, 4, fs, tx.shape[0])
    frontend.filtering(rec)

    sampled_sig = rec  # frontend.sampling(fs) # sampled version at 250 kHz
    sampled_sig2 = rec  # frontend.sampling(fs) # unsampled at 250*5 kHz
    # We can see a lot more detain in sampled sig2 and we use sampled_sig2 only for plotting.

    # plot the sampled sigal
    # plt.figure(4)
    # magr = np.abs(sampled_sig).max()*0.75
    # plt.plot(t,magr*np.cos(2.0*pi*t*fc)) # plot the reference local oscillator


    # for n in range(4):
    #     # plot an individual pulses from each hydrophones
    #     plt.plot(t, np.real(sampled_sig2[n,:]))
    # plt.xlabel("time (ms)")
    # plt.title("Sampled and filtered signals")
    # plt.legend(["carrier", "h1", "h2", "h3", "h4"])
    # plt.grid()
    # plt.show(block = False)

    # # try to detect peaks of each signal
    #
    # interval = np.nonzero((t >1.125)&(t<1.156   ))
    # id = interval[0]
    # carrier = np.cos(2.0*pi*t*35.0)
    # idx = np.nonzero(carrier[id]== carrier[id].max())
    # print "carrier peak time: %f"%t[id[idx[0]]]
    # for n in range(4):
    #     idx = np.nonzero(sampled_sig2[n,id]== sampled_sig2[n,id].max())
    #     print "peak for H%d: %f"%(n,t[id[idx[0]]])


    # Demodulate the signal
    # at 35 kHz with sampling rate of
    # 250 kHz (The maximum that AD can)
    demod = demodulate_module(sampled_sig, fc, fs)
    # Obtain baseband signal
    t2 = tx[::1]  # t2 for 250 KHz sampling rate

    baseband = demod.demoduate(t2)  # Here is the based band signal
    # plt.figure(5)
    # for n in range(4):
    #     plt.subplot(4,1,n+1)
    #     plt.plot(t2, np.real(baseband[n,:]), t2, np.imag(baseband[n,:]))
    #     plt.xlabel("time (ms)")
    #     plt.title("H%d"%n)
    #     plt.grid()
    # plt.show(block = False)
    pulses = CFARPulseDetection(baseband, 100, 1e-4, 4.0, fs)

    # detect pulse
    # n, pulse = pulseDetection(baseband, 4.0, fs)


    for str1, pulse in pulses:
        str = max(str1 - 200, 0)
        stp = str + pulse.shape[1] + 200
        print "pluse detect at %f s" % (str / fs + tx[0])
        plt.figure(6)
        t3 = np.arange(-200, pulse.shape[1] + 200)
        for n in range(4):
            plt.subplot(4, 1, n + 1)
            phase = np.arctan2(np.imag(pulse[n, :]), np.real(pulse[n, :])) * 180. / pi
            plt.plot(rec_sig[n,
                     str:stp])  # , t3, np.imag(baseband[n,str:(str+pulse.shape[1])])) #np.real(pulse[n,:]), t3,np.imag(pulse[n,:]) )
            plt.xlabel("time (ms)")
            plt.title("H%d pulse " % n)
            plt.grid()
        plt.show(block=True)

        # extract only sure part.
        sub_pulse = pulse[:, 0:-100]

        t1 = time.time()
        # Create athe bearingEstimator module
        # sub_pulse as input
        # set microphones at (0,0), (0,20), (20,0), (20,20) mm
        # signal freq. 35 kHz
        # Sampling rate: 250 kHz
        br = bearingEstimator(sub_pulse, np.array([[0, 0], [20, 0], [20, 20], [0, 20]]), fc, fs)
        # determine the arrival time with down sampling rate of 5
        #
        br.delay_time_estimator(1)
        # br.delay_time_estimator2(1)
        # estimate the arrival time of the main path with down sampling rate of 5
        az, ev, az_init, ev_init = br.bearingEstimatorForT0(1, fine_tune=True)
        t2 = time.time()
        print "The estimated arrival angle:"
        print "Azimuth: %f, Elevation: %f" % (az, ev)
        print "with processing time: %f" % (t2 - t1)
        # mode=raw_input('Press enter to exit:')
