# Architecture Documentation

## System Overview

This project implements a real-time edge detection system that combines Android native development, OpenCV image processing, OpenGL ES rendering, and a TypeScript web viewer.

## Component Architecture

### 1. Android Application Layer

#### MainActivity.java
**Responsibilities:**
- Camera lifecycle management
- UI component initialization
- Permission handling
- Frame processing coordination
- FPS calculation and display

**Key Methods:**
- `startCamera()`: Initializes CameraX and binds use cases
- `analyzeImage()`: Processes each camera frame
- `toggleProcessing()`: Switches between raw and processed views
- `updateFPS()`: Calculates and displays current FPS

**Flow:**
```
User Launch App → Check Permissions → Start Camera → 
Bind Preview + ImageAnalysis → Process Frames → Display Results
```

### 2. OpenGL Rendering Layer

#### EdgeDetectionRenderer.java
**Responsibilities:**
- OpenGL ES 2.0 context management
- Shader compilation and linking
- Texture creation and updates
- Frame rendering

**Shader Pipeline:**
1. **Vertex Shader**: Transforms vertices and passes texture coordinates
2. **Fragment Shader**: Samples texture and outputs pixel color

**Rendering Flow:**
```
Receive Processed Frame → Convert to RGBA Buffer → 
Update GL Texture → Bind Texture → Draw Quad → Display
```

**Key Features:**
- Double buffering for smooth rendering
- Texture filtering (GL_LINEAR)
- MVP matrix transformations
- Efficient buffer management

### 3. Native Processing Layer (C++)

#### native-lib.cpp (JNI Bridge)
**Responsibilities:**
- JNI method implementations
- Data marshalling between Java and C++
- OpenCV processor lifecycle management

**JNI Methods:**
- `initOpenCV()`: Initializes OpenCV processor
- `processFrame()`: Processes a single frame
- `cleanupOpenCV()`: Cleans up resources

#### opencv_processor.cpp
**Responsibilities:**
- OpenCV initialization
- Image format conversion
- Edge detection algorithm
- Performance optimization

**Processing Pipeline:**
```
YUV420 Input → RGB Conversion → Grayscale → 
Gaussian Blur → Canny Edge Detection → RGB Output
```

**Algorithm Details:**
- **Canny Edge Detection Parameters:**
  - Lower threshold: 50
  - Upper threshold: 150
  - Kernel size: 5x5 Gaussian blur

**Performance Optimizations:**
- Efficient memory management
- Minimal data copying
- Optimized OpenCV operations
- Frame resolution management

### 4. Web Viewer Layer (TypeScript)

#### viewer.ts
**Responsibilities:**
- Canvas-based frame display
- Statistics visualization
- User interaction handling
- Simulation mode

**Key Classes:**
- `EdgeDetectionViewer`: Main viewer controller
- `FrameData`: Frame data interface
- `ViewerStats`: Statistics interface

**Features:**
- Real-time FPS display
- Side-by-side comparison
- Frame export functionality
- Simulation mode (15 FPS)

## Data Flow Architecture

### Frame Processing Flow
```
┌─────────────────┐
│  Camera Sensor  │
└────────┬────────┘
         │ YUV420 Frame
         ▼
┌─────────────────┐
│   CameraX API   │
└────────┬────────┘
         │ ImageProxy
         ▼
┌─────────────────┐
│  MainActivity   │
└────────┬────────┘
         │ byte[]
         ▼
┌─────────────────┐
│   JNI Bridge    │
└────────┬────────┘
         │ unsigned char*
         ▼
┌─────────────────┐
│ OpenCV Processor│
│  - YUV to RGB   │
│  - Grayscale    │
│  - Blur         │
│  - Canny Edge   │
└────────┬────────┘
         │ int[] (ARGB)
         ▼
┌─────────────────┐
│ EdgeDetection   │
│    Renderer     │
└────────┬────────┘
         │ GL Texture
         ▼
┌─────────────────┐
│  GLSurfaceView  │
└─────────────────┘
```

### Memory Management

**Android Layer:**
- Camera buffers managed by CameraX
- Byte arrays for JNI transfer
- Int arrays for processed output

**Native Layer:**
- OpenCV Mat objects for image processing
- Automatic memory management via RAII
- Minimal heap allocations

**OpenGL Layer:**
- Texture memory on GPU
- Vertex/texture buffers
- Shader programs

## Performance Characteristics

### Target Metrics
- **FPS**: 15+ frames per second
- **Processing Time**: < 50ms per frame
- **Memory Usage**: < 100MB
- **Latency**: < 100ms end-to-end

### Optimization Strategies

1. **Frame Processing:**
   - Use STRATEGY_KEEP_ONLY_LATEST to skip frames
   - Process on background thread
   - Efficient YUV to RGB conversion

2. **OpenCV Operations:**
   - Optimized Canny parameters
   - Minimal intermediate buffers
   - Hardware acceleration where available

3. **OpenGL Rendering:**
   - Texture reuse
   - Efficient buffer updates
   - Minimal state changes

4. **Threading Model:**
   - Camera executor thread for frame capture
   - Native processing on executor thread
   - OpenGL rendering on GL thread
   - UI updates on main thread

## Error Handling

### Android Layer
- Permission denied handling
- Camera initialization failures
- Frame processing errors

### Native Layer
- OpenCV exceptions caught and logged
- Null pointer checks
- Buffer overflow protection

### OpenGL Layer
- Shader compilation error checking
- Texture allocation failures
- Context loss handling

## Extension Points

### 1. Additional Filters
Add new processing methods to `opencv_processor.cpp`:
```cpp
void OpenCVProcessor::applyGrayscale(unsigned char* data, int width, int height, int* output);
void OpenCVProcessor::applyBlur(unsigned char* data, int width, int height, int* output);
```

### 2. WebSocket Integration
Add real-time communication to web viewer:
```typescript
class WebSocketClient {
    connect(url: string): void;
    onFrameReceived(callback: (frame: FrameData) => void): void;
}
```

### 3. Multiple Camera Support
Extend MainActivity to support front/back camera switching:
```java
private void switchCamera() {
    cameraSelector = cameraSelector == CameraSelector.DEFAULT_BACK_CAMERA 
        ? CameraSelector.DEFAULT_FRONT_CAMERA 
        : CameraSelector.DEFAULT_BACK_CAMERA;
    bindCameraUseCases(cameraProvider);
}
```

### 4. Custom Shaders
Add shader effects in EdgeDetectionRenderer:
```glsl
// Invert colors shader
void main() {
    vec4 color = texture2D(uTexture, texCoord);
    gl_FragColor = vec4(1.0 - color.rgb, color.a);
}
```

## Testing Strategy

### Unit Tests
- OpenCV processor logic
- Frame data conversion
- Statistics calculation

### Integration Tests
- JNI bridge functionality
- Camera to OpenGL pipeline
- End-to-end frame processing

### Performance Tests
- FPS measurement
- Memory profiling
- CPU usage monitoring

## Deployment Considerations

### Android App
- Minimum SDK: API 21 (Android 5.0)
- Target SDK: API 34 (Android 14)
- Required permissions: CAMERA
- APK size: ~20-30 MB (with OpenCV)

### Web Viewer
- Modern browser required (ES2020 support)
- No server-side dependencies
- Can be hosted on any static file server

## Security Considerations

### Android App
- Camera permission requested at runtime
- No network permissions required
- No data storage or transmission

### Web Viewer
- Client-side only processing
- No external API calls
- No user data collection

## Future Enhancements

1. **Real-time Streaming**: WebSocket connection between Android and web viewer
2. **Multiple Filters**: Add more OpenCV filters (Sobel, Laplacian, etc.)
3. **Performance Profiling**: Built-in performance monitoring
4. **Video Recording**: Save processed video to device
5. **Cloud Integration**: Upload processed frames to cloud storage
6. **Machine Learning**: Integrate TensorFlow Lite for object detection



