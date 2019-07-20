#!/usr/bin/env python

# ROS system
import rospy
import std_msgs.msg

# User system
import threading
from lowpass import h_lp
import scipy.optimize as opt
from hydrophone_serial import hydrophone_serial
import numpy as np
from bearingEstimator import bearingEstimator
import demodulation
import matplotlib.pyplot as plt

from scipy.signal import butter, lfilter

# Hydrophone parameters
#### setting parameter ####
SerialPortName = "/dev/ttyACM0"
Sampling_rate = 191930
LowestFrequency = 30000
HighestFrequency = 41000
Frequency = 37500
SoundSpeed = 1500
FrontThreshold = 0.3
PowerThreshold = 0.02
DelayObserve = 2000
LNA_Gain = 0.2

#### current data from hydrophone ####
DataLock = threading.Lock()
TimeStamp = None
Azimuth = 0.0
Elevation = 0.0

#### Global data ####
HydrophonePort = None

def butterworth_bandpass_filter( sig, lowcut, highcut, f_sampling, order=9 ):
    nyq = 0.5 * f_sampling
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter( order, [low, high], btype="band" )
    sig_out = lfilter( b, a, sig )
    return sig_out

# The thread that receives and processes data from hydrophone hardware.
def hydrophone_data_thread():
    while True:
        if HydrophonePort != None:

            # Receive an array of signal consisting of 4 signal streams. Each stream is 2048 elements of ADC value in 4-byte float
            sig = HydrophonePort.get_pulse_data()
            current_time = rospy.Time.now()

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

            # Update data in global variables
            DataLock.acquire()
            TimeStamp = current_time
            Azimuth = az
            Elevation = ev
            DataLock.release()

            # Log the data to ROS
            rospy.loginfo( "Hydrophone in: Time (%i Sec), (%i nSec): Azumuth=%f Elevetion=%f", current_time.secs, current_time.nsecs, az, ev )


# ROS service node for sending hydrophone parameter
def hydrophone_ros_command_service( req ):
    current_time = rospy.Time.now()

    if HydrophonePort != None:
        # Retrieve pinger parameters
        Frequency = int( req.PingerFrequency )
        LowestFrequency = int( req.LowestFrequency )
        HighestFrequency = int( req.HighestFrequency )
        FrontThreshold = float( req.FrontThreshold )
        PowerThreshold = float( req.PowerThreshold )
        DelayObserve = int( req.DelayObserve )
        AmpGain = float( req.AmplifierNormalizedGain )

        # Log the setting
        rospy.loginfo( "Hydrophone at (%i Sec), (%i nSec): Set Pinger frequency=%i, Low-cut frequency=%i, High-cut frequency=%i, front threshold=%f, power threshold=%f, delay observe=%i, gain=%f", 
            Frequency, LowestFrequency, HighestFrequency, FrontThreshold, PowerThreshold, DelayObserve, AmpGain )
        HydrophonePort.sent_dsp_param(Frequency, LowestFrequency, HighestFrequency, FrontThreshold, PowerThreshold, DelayObserve, AmpGain)
        return True
    else:
        # Serial port error
        rospy.logerror( "Hydrophone at (%i Sec), (%i nSec): Unable to send command (Hydrophone not found)")
        return False

# ROS service node for reading hydrophone data
def hydrophone_ros_data_service( req ):
    resp = HydrophoneDataResponse()
    resp.header = std_msgs.msg.Header()
    resp.header.stamp = rospy.Time.now() # Note you need to call rospy.init_node() before this will work

    # Read data
    DataLock.acquire()
    resp.DataTimeStamp = TimeStamp
    resp.Azimuth = Azimuth
    resp.Elevation = Elevation
    DataLock.release()

    rospy.loginfo( "Hydrophone at (%i Sec), (%i nSec): Sending data with stamp=(%i Sec,%i nSec), azimuth=%f, elevation=%f",
        resp.header.stamp.secs, resp.header.stamp.nsecs, resp.TimeStamp.secs, resp.TimeStamp.nsecs, resp.Azimuth, resp.Elevation )
    return resp

# Main part
if __name__ == '__main__':
    # Execute only if run as script (not by "import")
    rospy.init_node( '/zeabus/hydrophone' )

    # Read parameters
    SerialPortName = rospy.get_param( "/zeabus_hydrophone/PortName", "/dev/ttyACM0" )
    Sampling_rate = int( rospy.get_param( "/zeabus_hydrophone/SamplingRate", 191930 ) )
    Frequency = int( rospy.get_param( "/zeabus_hydrophone/PingerFrequency", 37500 ) )
    LowestFrequency = int( rospy.get_param( "/zeabus_hydrophone/LowestFrequency", 20000 ) )
    HighestFrequency = int( rospy.get_param( "/zeabus_hydrophone/HighestFrequency", 42000 ) )
    SoundSpeed = int( rospy.get_param( "/zeabus_hydrophone/SoundSpeed", 1500 ) )
    FrontThreshold = float( rospy.get_param( "/zeabus_hydrophone/FrontThreshold", 0.3 ) )
    PowerThreshold = float( rospy.get_param( "/zeabus_hydrophone/PowerThreshold", 0.02 ) )
    DelayObserve = int( rospy.get_param( "/zeabus_hydrophone/DelayObserve", 2000 ) )
    AmpGain = float( rospy.get_param( "/zeabus_hydrophone/AmplifierNormalizedGain", 0.2 ) )

    # Initialize global system
    TimeStamp = rospy.Time.now()
    try:
        HydrophonePort = hydrophone_serial( SerialPortName )
    except serial.SerialException:
        rospy.logerror( "Failed to open hydrophone serial port !!!!" )
        HydrophonePort = None
    if HydrophonePort != None:
        HydrophonePort.sent_dsp_param(Frequency, FrontThreshold, PowerThreshold, DelayObserve, AmpGain)

    # Start threads and service nodes
    HydrophoneThread = threading.Thread( target="hydrophone_data_thread" )
    HydrophoneThread.start()
    HydrophoneCommandService = rospy.Service( "hydrophone_command", HydrophoneCommand, hydrophone_ros_command_service )
    HydrophoneDataService = rospy.Service( "hydrophone_command", HydrophoneData, hydrophone_ros_command_service )

    # Initailization done
    rospy.loginfo( "Hydrophone services are initialized.")
    rospy.spin()
