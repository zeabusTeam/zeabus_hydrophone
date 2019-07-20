cmake_minimum_required(VERSION 2.8.3)
project(zeabus_hydrophone)

# Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
    rospy
    message_generation
    std_msgs
)

# Generate services in the 'srv' directory
add_service_files(
    FILES
    HydrophoneCommand.srv
    HydrophoneData.srv
)

generate_messages(
    DEPENDENCIES
    std_msgs
)

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if your package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES python
    CATKIN_DEPENDS
    rospy
    message_runtime
#  DEPENDS system_lib
)
