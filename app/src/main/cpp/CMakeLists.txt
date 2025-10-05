cmake_minimum_required(VERSION 3.18.1)

project("edgeDetection")

# Set C++ standard
set(CMAKE_CXX_STANDARD 14)

# Try to find OpenCV from different possible locations
set(OpenCV_POSSIBLE_PATHS
    "C:/Users/korup/Downloads/opencv-4.12.0-android-sdk/OpenCV-android-sdk/sdk/native/jni"
    "C:/opencv-android-sdk/OpenCV-android-sdk/sdk/native/jni"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../opencv/sdk/native/jni"
)

# Find OpenCV
foreach(OPENCV_PATH ${OpenCV_POSSIBLE_PATHS})
    if(EXISTS "${OPENCV_PATH}")
        set(OpenCV_DIR "${OPENCV_PATH}")
        message(STATUS "Found OpenCV at: ${OpenCV_DIR}")
        break()
    endif()
endforeach()

# Set OpenCV_DIR if not found automatically
if(NOT OpenCV_DIR)
    set(OpenCV_DIR "C:/Users/korup/Downloads/opencv-4.12.0-android-sdk/OpenCV-android-sdk/sdk/native/jni")
    message(WARNING "OpenCV path not auto-detected, using default: ${OpenCV_DIR}")
endif()

find_package(OpenCV QUIET)

# Include directories and link libraries
if(OpenCV_FOUND)
    message(STATUS "OpenCV found! Building with OpenCV support.")
    include_directories(${OpenCV_INCLUDE_DIRS})
    
    # Add the native library
    add_library(
        edgeDetection
        SHARED
        native-lib.cpp
        opencv_processor.cpp
    )
    
    # Link libraries with OpenCV
    target_link_libraries(
        edgeDetection
        ${OpenCV_LIBS}
        android
        log
        GLESv2
    )
    
    # Define OpenCV available flag
    target_compile_definitions(edgeDetection PRIVATE OPENCV_AVAILABLE=1)
else()
    message(WARNING "OpenCV not found! Building basic version without OpenCV.")
    
    # Add the native library without OpenCV processor
    add_library(
        edgeDetection
        SHARED
        native-lib.cpp
    )
    
    # Link libraries without OpenCV
    target_link_libraries(
        edgeDetection
        android
        log
        GLESv2
    )
    
    # Define OpenCV not available flag
    target_compile_definitions(edgeDetection PRIVATE OPENCV_AVAILABLE=0)
endif()


