#include <jni.h>
#include <string>
#include <android/log.h>
#include "opencv_processor.h"

#define LOG_TAG "EdgeDetectionNative"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

OpenCVProcessor processor;

extern "C" JNIEXPORT void JNICALL
Java_com_flam_edgeDetection_MainActivity_initOpenCV(JNIEnv *env, jobject thiz) {
    LOGI("Initializing OpenCV processor");
    processor.init();
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
    
    // Process frame
    processor.processFrame(
        reinterpret_cast<unsigned char*>(inputData),
        width,
        height,
        outputData
    );
    
    // Release arrays
    env->ReleaseByteArrayElements(data, inputData, JNI_ABORT);
    env->ReleaseIntArrayElements(output, outputData, 0);
}

extern "C" JNIEXPORT void JNICALL
Java_com_flam_edgeDetection_MainActivity_cleanupOpenCV(JNIEnv *env, jobject thiz) {
    LOGI("Cleaning up OpenCV processor");
    processor.cleanup();
}



