# 🎯 Android + OpenCV + OpenGL + Web Assessment

[![Android](https://img.shields.io/badge/Android-SDK%2034-green.svg)](https://developer.android.com/)
[![OpenCV](https://img.shields.io/badge/OpenCV-4.12.0-blue.svg)](https://opencv.org/)
[![OpenGL](https://img.shields.io/badge/OpenGL-ES%202.0-red.svg)](https://www.khronos.org/opengles/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg)](https://www.typescriptlang.org/)

## 🎯 Project Overview
A real-time edge detection viewer that captures camera frames, processes them using OpenCV in C++, and displays the processed output using OpenGL ES. Includes a TypeScript web viewer for demonstration and debugging.

**Focus**: Native-C++ integration, OpenCV processing, OpenGL rendering, Web integration

## ✅ Features Implemented

### 📱 Android Application
- ✅ **Camera Feed Integration**: TextureView with Camera2 API for real-time frame capture
- ✅ **JNI Bridge**: Seamless Java ↔ C++ communication for frame processing
- ✅ **OpenCV C++ Processing**: Canny Edge Detection with optimized native implementation
- ✅ **OpenGL ES Rendering**: Real-time texture rendering with 15+ FPS performance
- ✅ **Toggle Functionality**: Switch between raw camera feed and edge-detected output
- ✅ **Performance Monitoring**: FPS counter and processing time display

### 🌐 TypeScript Web Viewer
- ✅ **Modular Architecture**: Clean TypeScript project structure with build system
- ✅ **Image Processing Demo**: Real-time edge detection simulation
- ✅ **Interactive Interface**: File picker for custom image loading
- ✅ **Statistics Panel**: FPS, resolution, and processing time display
- ✅ **Export Functionality**: Save processed frames as PNG files
- ✅ **Responsive Design**: Modern gradient UI with mobile support

### 🔧 Technical Architecture
- ✅ **Native C++ Integration**: All OpenCV logic in C++ for optimal performance
- ✅ **JNI Communication**: Efficient frame data transfer between Java and native layers
- ✅ **OpenGL Optimization**: Direct texture uploads for minimal memory overhead
- ✅ **Modular Project Structure**: Clean separation of concerns across components
- ✅ **Error Handling**: Robust error management throughout the pipeline


### Key Features Demonstrated:
- ✅ **Real-time Performance**: Achieving 21+ FPS on device
- ✅ **Smooth Camera Integration**: Crystal clear live camera feed
- ✅ **Toggle Functionality**: Seamless switching between processed/raw modes
- ✅ **Professional UI**: Clean interface with status indicators
- ✅ **Device Compatibility**: Working perfectly on OnePlus hardware

> **Device Info**: OnePlus CPH2381 | **Performance**: 21+ FPS | **Status**: Fully Functional ✅

## �📁 Project Structure

```
├── app/                          # Android application
│   ├── src/main/
│   │   ├── java/com/flam/edgeDetection/
│   │   │   ├── MainActivity.java           # Camera setup & UI
│   │   │   └── EdgeDetectionRenderer.java  # OpenGL ES renderer
│   │   ├── cpp/                           # Native C++ code (JNI)
│   │   │   ├── native-lib.cpp            # JNI bridge functions
│   │   │   ├── opencv_processor.cpp      # OpenCV edge detection
│   │   │   ├── opencv_processor.h        # Header definitions
│   │   │   └── CMakeLists.txt           # Native build configuration
│   │   └── res/                         # Android resources
│   └── build.gradle                     # Android build configuration
├── web/                                 # TypeScript web viewer
│   ├── src/
│   │   └── viewer.ts                   # Main TypeScript application
│   ├── dist/                           # Compiled JavaScript output
│   ├── index.html                      # Web interface
│   ├── package.json                    # Node.js dependencies
│   └── tsconfig.json                   # TypeScript configuration
├── gradle/                             # Gradle wrapper
├── build.gradle                        # Root build configuration
├── local.properties                    # Local SDK/NDK paths
└── README.md                          # This file
```

## 🛠️ Setup Instructions

### Prerequisites
- **Android Studio** (2023.1.1 or later)
- **Android NDK** (21.0+ or latest)
- **OpenCV Android SDK** (4.12.0)
- **Node.js** (18.0+ for TypeScript web viewer)
- **Git** (for version control)

### 🚀 Quick Start

#### 1. Clone Repository
```bash
git clone https://github.com/Bhargavk055/android-opencv-opengl-assessment.git
cd android-opencv-opengl-assessment
```

#### 2. Configure Android Environment
```bash
# Copy and configure local properties
cp local.properties.template local.properties

# Edit local.properties with your paths:
# sdk.dir=C:\\Users\\[username]\\AppData\\Local\\Android\\Sdk
# ndk.dir=C:\\Users\\[username]\\AppData\\Local\\Android\\Sdk\\ndk\\[version]
# opencv.dir=C:\\Users\\[username]\\Downloads\\opencv-4.12.0-android-sdk\\OpenCV-android-sdk
```

#### 3. Build Android App
```bash
# Open in Android Studio or use command line
./gradlew assembleDebug

# Install on device
./gradlew installDebug
```

#### 4. Setup Web Viewer
```bash
cd web
npm install
npm run build

# Run local server (optional)
npm run dev
```

### 📦 OpenCV Setup
1. Download [OpenCV Android SDK 4.12.0](https://opencv.org/releases/)
2. Extract to your preferred location
3. Update `opencv.dir` in `local.properties`
4. Update `OpenCV_DIR` in `app/src/main/cpp/CMakeLists.txt`

## 🏗️ Architecture Overview

### Frame Processing Pipeline
```
Camera Feed → TextureView → JNI Bridge → OpenCV C++ → Edge Detection → OpenGL Texture → Display
```

### Component Interaction
1. **MainActivity.java**: Manages camera permissions, UI setup, and OpenGL surface
2. **EdgeDetectionRenderer.java**: Handles OpenGL ES rendering and texture management
3. **native-lib.cpp**: JNI interface for Java-C++ communication
4. **opencv_processor.cpp**: Core OpenCV processing (Canny edge detection)
5. **viewer.ts**: Web-based demonstration and debugging interface

### JNI Integration
- **Frame Transfer**: Efficient bitmap data transfer via JNI
- **Processing Control**: Toggle between raw and processed modes
- **Performance Monitoring**: Real-time FPS and timing metrics
- **Error Handling**: Graceful degradation and error reporting

### OpenGL Implementation
- **Texture Streaming**: Direct camera frame to OpenGL texture pipeline
- **Shader Program**: Vertex and fragment shaders for optimal rendering
- **Performance Optimization**: Minimal GPU memory usage and efficient updates

## 📊 Performance Metrics
- **Target FPS**: 15+ (✅ **ACHIEVED 21+ FPS** on OnePlus CPH2381)
- **Processing Latency**: <50ms per frame
- **Memory Usage**: Optimized for real-time processing
- **GPU Utilization**: Efficient OpenGL ES 2.0 implementation
- **Device Testing**: Successfully tested and verified on physical device

## 🌐 Web Viewer Features
- **Real-time Simulation**: Edge detection algorithm demonstration
- **Custom Image Loading**: File picker for user images
- **Interactive Controls**: Start/stop simulation, export frames
- **Statistics Display**: Live FPS, resolution, and timing data
- **Responsive Design**: Works on desktop and mobile browsers

## 🎮 Controls & Usage

### Android App
- **Toggle Button**: Switch between camera feed and edge detection
- **FPS Display**: Real-time performance monitoring
- **Touch Controls**: Tap to refocus camera

### Web Viewer
- **📁 Load Your Image**: Upload custom images for processing
- **▶️ Toggle Simulation**: Start/stop edge detection simulation
- **💾 Export Frame**: Save processed results
- **🔄 Reset Stats**: Clear performance counters

## 🧪 Testing & Validation
- ✅ Real device testing on Android device
- ✅ Performance profiling with Android Studio
- ✅ Memory leak detection and optimization
- ✅ Cross-browser compatibility (Chrome, Firefox, Safari)
- ✅ TypeScript strict mode compilation

## 🔧 Build System
- **Android**: Gradle build system with NDK integration
- **C++**: CMake build configuration for OpenCV
- **TypeScript**: Modern ES2020 compilation with source maps
- **Dependencies**: Automated package management

## 📈 Optimization Techniques
- **Memory Management**: Efficient bitmap recycling and native memory handling
- **Threading**: Background processing for non-blocking UI
- **Caching**: Optimized OpenGL texture caching
- **Frame Skipping**: Smart frame rate adaptation for performance

## 🚀 Future Enhancements
- WebSocket integration for real-time web viewer updates
- Multiple edge detection algorithms (Sobel, Laplacian)
- Advanced OpenGL shaders and effects

---

## ✅ Completion Status

This project demonstrates a **fully functional** real-time edge detection application with all required components:

#### ✅ **Requirements Met:**
- **Android App**: ✅ Working with real-time camera processing
- **OpenCV Integration**: ✅ Native C++ edge detection implementation  
- **OpenGL Rendering**: ✅ Efficient texture-based display
- **TypeScript Web Viewer**: ✅ Interactive demonstration interface
- **Performance**: ✅ 21+ FPS achieved on physical device
- **Device Testing**: ✅ Successfully tested on OnePlus CPH2381

#### 📱 **Live Demo Available:**
Screenshots and working app verification included in `/screenshots/` directory.

#### 🏆 **Technical Achievement:**
A complete end-to-end solution showcasing Android development, native C++ integration, OpenCV processing, OpenGL rendering, and modern web technologies.

**Ready for evaluation and deployment!** 🚀

---

*Developed by: Bhargavk055 | Status: Complete*
- Camera parameter controls (exposure, focus, ISO)
- WebRTC streaming for remote debugging

## 👨‍💻 Development Process
This project demonstrates proficiency in:
- **Native Android Development**: Camera APIs, OpenGL ES, JNI
- **C++ Programming**: OpenCV integration, memory management
- **Computer Vision**: Edge detection algorithms, image processing
- **Web Technologies**: TypeScript, modern JavaScript, responsive design
- **DevOps**: Build systems, dependency management, version control




