# Android + OpenCV + OpenGL Edge Detection Setup Guide

## Prerequisites Installation

### 1. Android Studio Setup
1. Download and install [Android Studio](https://developer.android.com/studio) (latest version)
2. Open Android Studio and install:
   - Android SDK Platform 34
   - Android SDK Build-Tools 34.0.0
   - NDK (Side by side) version 21 or later
   - CMake 3.18.1 or later

### 2. OpenCV Android SDK Setup
1. Download OpenCV Android SDK from [OpenCV Releases](https://opencv.org/releases/)
   - Recommended: OpenCV 4.8.0 or later
2. Extract the downloaded zip file to a location on your computer
3. Note the path to the extracted folder (e.g., `C:\opencv-android-sdk`)

### 3. Node.js Setup (for Web Viewer)
1. Download and install [Node.js](https://nodejs.org/) (LTS version)
2. Verify installation:
   ```bash
   node --version
   npm --version
   ```

## Project Setup

### Step 1: Clone the Repository
```bash
git clone <your-repository-url>
cd Flam\ assignment
```

### Step 2: Configure OpenCV Path
1. Create or edit `local.properties` in the project root
2. Add the OpenCV SDK path:
   ```properties
   sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
   ndk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529
   opencv.dir=C\:\\path\\to\\opencv-android-sdk
   ```

### Step 3: Update CMakeLists.txt
1. Open `app/src/main/cpp/CMakeLists.txt`
2. Update the OpenCV path if needed:
   ```cmake
   set(OpenCV_DIR "C:/path/to/opencv-android-sdk/sdk/native/jni")
   find_package(OpenCV REQUIRED)
   ```

### Step 4: Build Android App
1. Open the project in Android Studio
2. Wait for Gradle sync to complete
3. Build the project: `Build > Make Project`
4. Connect an Android device or start an emulator
5. Run the app: `Run > Run 'app'`

### Step 5: Setup Web Viewer
```bash
cd web
npm install
npm run build
```

### Step 6: Run Web Viewer
```bash
# Open index.html in a browser, or use a local server:
cd web
python -m http.server 8080
# Then open http://localhost:8080 in your browser
```

## Troubleshooting

### OpenCV Not Found
- Ensure OpenCV SDK path is correct in `local.properties`
- Check that CMakeLists.txt points to the correct OpenCV directory
- Verify OpenCV Android SDK is properly extracted

### NDK Build Errors
- Ensure NDK is installed via Android Studio SDK Manager
- Check NDK version compatibility (21 or later recommended)
- Clean and rebuild: `Build > Clean Project` then `Build > Rebuild Project`

### Camera Permission Issues
- Grant camera permission when prompted
- Check app permissions in device settings
- Ensure `AndroidManifest.xml` includes camera permissions

### Performance Issues
- Test on a physical device (emulators may be slow)
- Reduce camera resolution if needed
- Check for memory leaks in native code

## Architecture Overview

### Android App Flow
1. **MainActivity**: Manages UI and camera lifecycle
2. **Camera Capture**: Uses CameraX API to capture frames
3. **JNI Bridge**: Sends frames to native C++ code
4. **OpenCV Processing**: Applies Canny edge detection
5. **OpenGL Rendering**: Displays processed frames as textures

### Native Code Structure
- `native-lib.cpp`: JNI interface methods
- `opencv_processor.cpp`: OpenCV image processing logic
- `opencv_processor.h`: Header file for processor class

### Web Viewer
- TypeScript-based viewer for displaying processed frames
- Simulates real-time processing with sample data
- Can be extended to receive data via WebSocket

## Performance Targets
- **Target FPS**: 15+ frames per second
- **Processing Time**: < 50ms per frame
- **Memory Usage**: < 100MB

## Testing
1. Launch the Android app
2. Grant camera permission
3. Verify edge detection is working
4. Check FPS counter (should be 10-15 FPS minimum)
5. Toggle between raw and processed views
6. Open web viewer to see sample processed frames

## Additional Resources
- [OpenCV Documentation](https://docs.opencv.org/)
- [Android NDK Guide](https://developer.android.com/ndk/guides)
- [OpenGL ES 2.0 Tutorial](https://developer.android.com/training/graphics/opengl)
- [CameraX Documentation](https://developer.android.com/training/camerax)



