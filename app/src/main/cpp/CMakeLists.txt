cmake_minimum_required(VERSION 3.18.1)

project("edgeDetection")

# Set C++ standard
set(CMAKE_CXX_STANDARD 14)

# Find OpenCV
set(OpenCV_DIR "C:/Users/korup/Downloads/opencv-4.12.0-android-sdk/OpenCV-android-sdk/sdk/native/jni")
find_package(OpenCV REQUIRED)

# Include directories
include_directories(${OpenCV_INCLUDE_DIRS})

# Add the native library
add_library(
    edgeDetection
    SHARED
    native-lib.cpp
    opencv_processor.cpp
)

# Link libraries
target_link_libraries(
    edgeDetection
    ${OpenCV_LIBS}
    android
    log
    GLESv2
)


