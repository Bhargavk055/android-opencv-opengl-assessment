#ifndef OPENCV_PROCESSOR_H
#define OPENCV_PROCESSOR_H

#include <opencv2/opencv.hpp>

class OpenCVProcessor {
public:
    OpenCVProcessor();
    ~OpenCVProcessor();
    
    void init();
    void processFrame(unsigned char* data, int width, int height, int* output);
    void cleanup();
    
private:
    bool initialized;
};

#endif // OPENCV_PROCESSOR_H



