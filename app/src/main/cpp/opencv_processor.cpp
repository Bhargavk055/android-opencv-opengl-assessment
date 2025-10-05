#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <android/log.h>
#include "opencv_processor.h"

#define LOG_TAG "OpenCVProcessor"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

OpenCVProcessor::OpenCVProcessor() : initialized(false) {
}

OpenCVProcessor::~OpenCVProcessor() {
    cleanup();
}

void OpenCVProcessor::init() {
    if (initialized) {
        return;
    }
    
    LOGI("Initializing OpenCV processor");
    
    // Initialize OpenCV (if needed)
    // OpenCV is usually auto-initialized on Android
    
    initialized = true;
    LOGI("OpenCV processor initialized successfully");
}

void OpenCVProcessor::processFrame(unsigned char* data, int width, int height, int* output) {
    if (!initialized) {
        LOGE("Processor not initialized");
        return;
    }
    
    try {
        // Create OpenCV Mat from input data (assuming YUV420 format)
        cv::Mat yuvMat(height + height/2, width, CV_8UC1, data);
        cv::Mat rgbMat;
        
        // Convert YUV420 to RGB
        cv::cvtColor(yuvMat, rgbMat, cv::COLOR_YUV2RGB_NV21);
        
        // Resize if needed for performance
        cv::Mat resizedMat;
        cv::resize(rgbMat, resizedMat, cv::Size(width, height));
        
        // Convert to grayscale
        cv::Mat grayMat;
        cv::cvtColor(resizedMat, grayMat, cv::COLOR_RGB2GRAY);
        
        // Apply Gaussian blur to reduce noise
        cv::Mat blurredMat;
        cv::GaussianBlur(grayMat, blurredMat, cv::Size(5, 5), 0);
        
        // Apply Canny edge detection
        cv::Mat edgeMat;
        cv::Canny(blurredMat, edgeMat, 50, 150);
        
        // Convert back to RGB for display
        cv::Mat resultMat;
        cv::cvtColor(edgeMat, resultMat, cv::COLOR_GRAY2RGB);
        
        // Convert to int array for OpenGL texture
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                cv::Vec3b pixel = resultMat.at<cv::Vec3b>(y, x);
                int index = y * width + x;
                
                // Pack RGB into int (ARGB format)
                output[index] = (0xFF << 24) |           // Alpha
                               (pixel[0] << 16) |        // Red
                               (pixel[1] << 8) |         // Green
                               pixel[2];                 // Blue
            }
        }
        
    } catch (const cv::Exception& e) {
        LOGE("OpenCV error: %s", e.what());
    } catch (const std::exception& e) {
        LOGE("Processing error: %s", e.what());
    }
}

void OpenCVProcessor::cleanup() {
    if (!initialized) {
        return;
    }
    
    LOGI("Cleaning up OpenCV processor");
    initialized = false;
}



