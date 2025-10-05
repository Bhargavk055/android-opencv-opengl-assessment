#include <jni.h>
#include <string>
#include <android/log.h>

#ifdef OPENCV_AVAILABLE
#include "opencv_processor.h"
#endif

#define LOG_TAG "EdgeDetectionNative"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#ifdef OPENCV_AVAILABLE
OpenCVProcessor processor;
#endif

extern "C" JNIEXPORT void JNICALL
Java_com_flam_edgeDetection_MainActivity_initOpenCV(JNIEnv *env, jobject thiz) {
    LOGI("Initializing processor");
#ifdef OPENCV_AVAILABLE
    processor.init();
    LOGI("OpenCV processor initialized");
#else
    LOGI("OpenCV not available - using basic processor");
#endif
}

extern "C" JNIEXPORT void JNICALL
Java_com_flam_edgeDetection_MainActivity_processFrame(
    JNIEnv *env, 
    jobject thiz,
    jbyteArray data,
    jint width,
    jint height,
    jintArray output) {
    
    // Get input data
    jbyte* inputData = env->GetByteArrayElements(data, nullptr);
    jint* outputData = env->GetIntArrayElements(output, nullptr);
    
#ifdef OPENCV_AVAILABLE
    // Process frame with OpenCV
    processor.processFrame(
        reinterpret_cast<unsigned char*>(inputData),
        width,
        height,
        outputData
    );
#else
    // Basic processing without OpenCV - just copy/invert
    for (int i = 0; i < width * height; i++) {
        int pixel = inputData[i] & 0xFF;
        // Simple inversion as placeholder
        int inverted = 255 - pixel;
        outputData[i] = (0xFF << 24) | (inverted << 16) | (inverted << 8) | inverted;
    }
    LOGI("Processed frame without OpenCV (basic inversion)");
#endif
    
    // Release arrays
    env->ReleaseByteArrayElements(data, inputData, JNI_ABORT);
    env->ReleaseIntArrayElements(output, outputData, 0);
}

extern "C" JNIEXPORT void JNICALL
Java_com_flam_edgeDetection_MainActivity_cleanupOpenCV(JNIEnv *env, jobject thiz) {
    LOGI("Cleaning up processor");
#ifdef OPENCV_AVAILABLE
    processor.cleanup();
    LOGI("OpenCV processor cleaned up");
#else
    LOGI("Basic processor cleanup complete");
#endif
}



