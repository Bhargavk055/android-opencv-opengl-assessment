# Android + OpenCV + OpenGL + Web Assessment

## 🎯 Project Overview
A real-time edge detection viewer that captures camera frames, processes them using OpenCV in C++, and displays the processed output using OpenGL ES. Includes a TypeScript web viewer for demonstration.

## ✅ Features Implemented

### Android App
- ✅ Camera feed integration using TextureView
- ✅ Real-time frame capture (Camera2 API)
- ✅ JNI bridge for native C++ processing
- ✅ OpenCV C++ edge detection (Canny algorithm)
- ✅ OpenGL ES 2.0 rendering
- ✅ Performance optimization (targeting 15+ FPS)
- ✅ Toggle between raw camera and processed output
- ✅ FPS counter display

### Web Viewer (TypeScript)
- ✅ TypeScript-based web page
- ✅ Static processed frame display
- ✅ Frame statistics overlay (FPS, resolution)
- ✅ Modular TypeScript architecture
- ✅ Build system with tsc

## 📷 Screenshots

### Android App
*To be added: Screenshots of the Android app showing:*
- Camera preview with edge detection overlay
- FPS counter display
- Toggle button functionality
- Real-time processing at 15+ FPS

### Web Viewer
*To be added: Screenshots of the web viewer showing:*
- Side-by-side original and processed frames
- Statistics panel with FPS and resolution
- Modern gradient UI design
- Simulation mode in action

## ⚙️ Setup Instructions

### Prerequisites
- Android Studio (latest version)
- Android NDK (r21 or later)
- OpenCV Android SDK
- Node.js (for TypeScript web viewer)

### Quick Start

#### Option 1: Use Quick Start Script
```bash
# On Linux/Mac
chmod +x quickstart.sh
./quickstart.sh

# On Windows
quickstart.bat
```

#### Option 2: Manual Setup

**Android Setup:**
1. Clone the repository
   ```bash
   git clone <your-repository-url>
   cd "Flam assignment"
   ```

2. Open project in Android Studio

3. Install required components via SDK Manager:
   - Android SDK Platform 34
   - Android SDK Build-Tools 34.0.0
   - NDK (Side by side) - version 21 or later
   - CMake 3.18.1 or later

4. Download OpenCV Android SDK:
   - Visit https://opencv.org/releases/
   - Download OpenCV 4.8.0 or later for Android
   - Extract to a location on your computer

5. Configure OpenCV path:
   - Copy `local.properties.template` to `local.properties`
   - Update paths in `local.properties`:
     ```properties
     sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
     ndk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529
     opencv.dir=C\:\\path\\to\\opencv-android-sdk
     ```

6. Update CMakeLists.txt with OpenCV path:
   ```cmake
   set(OpenCV_DIR "C:/path/to/opencv-android-sdk/sdk/native/jni")
   ```

7. Build and run:
   - Build > Make Project
   - Run > Run 'app'
   - Grant camera permission when prompted

**Web Viewer Setup:**
1. Navigate to web directory
   ```bash
   cd web
   ```

2. Install dependencies
   ```bash
   npm install
   ```

3. Build TypeScript
   ```bash
   npm run build
   ```

4. Run web viewer
   ```bash
   # Option 1: Open index.html directly in browser
   # Option 2: Use local server
   python -m http.server 8080
   # Then visit http://localhost:8080
   ```

For detailed setup instructions, see [SETUP.md](SETUP.md)

## 🧠 Architecture Explanation

### Frame Flow
1. **Camera Capture**: TextureView captures frames from camera
2. **JNI Bridge**: Frames sent to native C++ via JNI
3. **OpenCV Processing**: Canny edge detection applied in C++
4. **OpenGL Rendering**: Processed frames rendered as textures
5. **Web Integration**: Static frames can be exported to web viewer

### Key Components
- **JNI Layer**: Handles Java ↔ C++ communication
- **OpenCV Module**: Image processing algorithms
- **OpenGL Renderer**: Real-time texture rendering
- **TypeScript Web**: Static frame display and statistics

## 🚀 Performance
- Target: 15+ FPS real-time processing
- Optimized for mobile devices
- Memory-efficient frame handling

## 📁 Project Structure
```
├── app/                    # Android Java/Kotlin code
├── jni/                    # C++ OpenCV processing
├── gl/                     # OpenGL renderer classes
├── web/                    # TypeScript web viewer
└── README.md              # This file
```

## 🔧 Tech Stack
- **Android SDK** (Java) - UI and camera management
- **NDK** (Native Development Kit) - Native C++ integration
- **OpenGL ES 2.0** - Hardware-accelerated rendering
- **OpenCV 4.8+** (C++) - Image processing algorithms
- **JNI** - Java ↔ C++ communication bridge
- **TypeScript** - Type-safe web viewer
- **CameraX** - Modern camera API
- **CMake** - Native build system

## 📚 Additional Documentation

- [SETUP.md](SETUP.md) - Detailed setup instructions and troubleshooting
- [ARCHITECTURE.md](ARCHITECTURE.md) - In-depth architecture documentation
- [GIT_STRATEGY.md](GIT_STRATEGY.md) - Git workflow and commit guidelines
- [web/README.md](web/README.md) - Web viewer specific documentation

## 🎯 Assessment Requirements Checklist

### Must-Have Features
- ✅ Camera feed integration using TextureView/SurfaceTexture
- ✅ Frame processing via OpenCV C++ (Canny edge detection)
- ✅ OpenGL ES 2.0 rendering with texture mapping
- ✅ Real-time performance (15+ FPS target)
- ✅ TypeScript web viewer with frame display
- ✅ Modular project structure (/app, /jni, /gl, /web)
- ✅ Proper Git repository with meaningful commits

### Bonus Features
- ✅ Toggle button between raw and processed views
- ✅ FPS counter display
- ✅ Frame statistics (resolution, processing time)
- ✅ Modern, responsive web UI
- ✅ Export frame functionality
- ✅ Simulation mode for web viewer

### Documentation
- ✅ Comprehensive README with features and setup
- ✅ Architecture explanation
- ✅ Setup instructions with troubleshooting
- ✅ Git commit strategy guide
- ✅ Code comments and documentation

## 🚀 Performance Metrics

### Target Performance
- **FPS**: 15+ frames per second
- **Processing Time**: < 50ms per frame
- **Memory Usage**: < 100MB
- **Latency**: < 100ms end-to-end

### Optimization Techniques
- Frame skipping with STRATEGY_KEEP_ONLY_LATEST
- Efficient YUV to RGB conversion
- Optimized Canny edge detection parameters
- GPU-accelerated OpenGL rendering
- Background thread processing
- Minimal memory allocations

## 🔍 Key Implementation Details

### Edge Detection Algorithm
- **Algorithm**: Canny Edge Detection
- **Pre-processing**: Gaussian blur (5x5 kernel)
- **Thresholds**: Lower=50, Upper=150
- **Color Space**: YUV420 → RGB → Grayscale

### OpenGL Rendering
- **Shaders**: Vertex + Fragment shaders
- **Texture Format**: RGBA
- **Rendering Mode**: RENDERMODE_CONTINUOUSLY
- **Buffer Management**: Double buffering

### JNI Bridge
- **Data Transfer**: Byte arrays for input, int arrays for output
- **Memory Management**: Automatic cleanup with JNI_ABORT
- **Error Handling**: Exception catching in native code

## 🛠️ Troubleshooting

### Common Issues

**OpenCV Not Found**
```bash
# Ensure OpenCV path is correct in local.properties
opencv.dir=C\:\\path\\to\\opencv-android-sdk

# Update CMakeLists.txt
set(OpenCV_DIR "C:/path/to/opencv-android-sdk/sdk/native/jni")
```

**NDK Build Errors**
```bash
# Install NDK via Android Studio SDK Manager
# Tools > SDK Manager > SDK Tools > NDK (Side by side)
```

**Low FPS**
- Test on physical device (not emulator)
- Reduce camera resolution
- Check for memory leaks
- Profile with Android Profiler

**Camera Permission Denied**
- Grant permission in app settings
- Check AndroidManifest.xml
- Request permission at runtime

## 📝 License
MIT License - Feel free to use this code for learning and development

## 👨‍💻 Author
Flam Assessment - Android + OpenCV + OpenGL + Web RnD Intern

## 🙏 Acknowledgments
- OpenCV community for excellent documentation
- Android CameraX team for modern camera API
- TypeScript team for type-safe JavaScript
