# Project Structure Visualization

## 📊 Complete Project Tree

```
Flam assignment/
│
├── 📱 ANDROID APPLICATION
│   │
│   ├── app/
│   │   │
│   │   ├── 📄 build.gradle                    # App build configuration
│   │   ├── 📄 proguard-rules.pro              # ProGuard rules
│   │   │
│   │   └── src/main/
│   │       │
│   │       ├── 📄 AndroidManifest.xml         # App manifest & permissions
│   │       │
│   │       ├── java/com/flam/edgeDetection/
│   │       │   ├── 📄 MainActivity.java       # Main activity (Camera + UI)
│   │       │   └── 📄 EdgeDetectionRenderer.java  # OpenGL renderer
│   │       │
│   │       ├── cpp/                           # Native C++ code
│   │       │   ├── 📄 CMakeLists.txt          # CMake build config
│   │       │   ├── 📄 native-lib.cpp          # JNI bridge
│   │       │   ├── 📄 opencv_processor.cpp    # OpenCV processing
│   │       │   └── 📄 opencv_processor.h      # Processor header
│   │       │
│   │       └── res/                           # Android resources
│   │           ├── layout/
│   │           │   └── 📄 activity_main.xml   # Main layout
│   │           ├── values/
│   │           │   ├── 📄 strings.xml         # String resources
│   │           │   ├── 📄 colors.xml          # Color definitions
│   │           │   └── 📄 themes.xml          # App themes
│   │           └── xml/
│   │               ├── 📄 backup_rules.xml
│   │               └── 📄 data_extraction_rules.xml
│   │
│   ├── 📄 build.gradle                        # Root build config
│   ├── 📄 settings.gradle                     # Project settings
│   └── 📄 gradle.properties                   # Gradle properties
│
├── 🌐 WEB VIEWER
│   │
│   └── web/
│       │
│       ├── src/
│       │   └── 📄 viewer.ts                   # TypeScript viewer
│       │
│       ├── dist/                              # Compiled output (generated)
│       │   └── 📄 viewer.js
│       │
│       ├── 📄 index.html                      # Web interface
│       ├── 📄 package.json                    # npm configuration
│       ├── 📄 tsconfig.json                   # TypeScript config
│       └── 📄 README.md                       # Web viewer docs
│
├── 📚 DOCUMENTATION
│   │
│   ├── 📄 START_HERE.md                       # ⭐ Start here!
│   ├── 📄 README.md                           # Main documentation
│   ├── 📄 SETUP.md                            # Setup instructions
│   ├── 📄 ARCHITECTURE.md                     # Technical architecture
│   ├── 📄 GIT_STRATEGY.md                     # Git guidelines
│   ├── 📄 PROJECT_SUMMARY.md                  # Assessment summary
│   ├── 📄 SUBMISSION_CHECKLIST.md             # Pre-submission checklist
│   ├── 📄 DOCUMENTATION_INDEX.md              # This file
│   └── 📄 PROJECT_STRUCTURE.md                # Visual structure guide
│
├── 🛠️ CONFIGURATION
│   │
│   ├── 📄 .gitignore                          # Git ignore rules
│   └── 📄 local.properties.template           # Config template
│
└── 🚀 SETUP SCRIPTS
    │
    ├── 📄 quickstart.sh                       # Quick setup (Unix)
    ├── 📄 quickstart.bat                      # Quick setup (Windows)
    ├── 📄 init-git.sh                         # Git init (Unix)
    └── 📄 init-git.bat                        # Git init (Windows)
```

## 🔄 Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        ANDROID APPLICATION                       │
└─────────────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │   Camera     │  (CameraX API)
    │   Hardware   │
    └──────┬───────┘
           │ YUV420 Frame
           ▼
    ┌──────────────┐
    │  MainActivity│  (Java)
    │  - Camera    │
    │  - UI        │
    │  - FPS       │
    └──────┬───────┘
           │ byte[]
           ▼
    ┌──────────────┐
    │  JNI Bridge  │  (native-lib.cpp)
    │  - Marshal   │
    │  - Convert   │
    └──────┬───────┘
           │ unsigned char*
           ▼
    ┌──────────────┐
    │   OpenCV     │  (opencv_processor.cpp)
    │  Processor   │
    │  - YUV→RGB   │
    │  - Grayscale │
    │  - Blur      │
    │  - Canny     │
    └──────┬───────┘
           │ int[] (ARGB)
           ▼
    ┌──────────────┐
    │   OpenGL     │  (EdgeDetectionRenderer.java)
    │  Renderer    │
    │  - Texture   │
    │  - Shaders   │
    │  - Display   │
    └──────┬───────┘
           │ Rendered Frame
           ▼
    ┌──────────────┐
    │ GLSurfaceView│
    │   Display    │
    └──────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                          WEB VIEWER                              │
└─────────────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │  index.html  │  (HTML5)
    │  - Canvas    │
    │  - UI        │
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │  viewer.ts   │  (TypeScript)
    │  - Render    │
    │  - Stats     │
    │  - Simulate  │
    │  - Export    │
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │   Browser    │
    │   Display    │
    └──────────────┘
```

## 🏗️ Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                          │
├─────────────────────────────────────────────────────────────────┤
│  MainActivity.java          │  index.html + viewer.ts           │
│  - UI Components            │  - Canvas Rendering               │
│  - User Interaction         │  - Statistics Display             │
│  - Permission Handling      │  - User Controls                  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      RENDERING LAYER                             │
├─────────────────────────────────────────────────────────────────┤
│  EdgeDetectionRenderer.java │  Canvas 2D Context                │
│  - OpenGL ES 2.0            │  - 2D Drawing                     │
│  - Texture Management       │  - Image Display                  │
│  - Shader Programs          │  - Export Functions               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      PROCESSING LAYER                            │
├─────────────────────────────────────────────────────────────────┤
│  opencv_processor.cpp                                            │
│  - Image Format Conversion                                       │
│  - Canny Edge Detection                                          │
│  - Gaussian Blur                                                 │
│  - Performance Optimization                                      │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      INTEGRATION LAYER                           │
├─────────────────────────────────────────────────────────────────┤
│  native-lib.cpp (JNI Bridge)                                     │
│  - Java ↔ C++ Communication                                     │
│  - Data Marshalling                                              │
│  - Memory Management                                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      DATA SOURCE LAYER                           │
├─────────────────────────────────────────────────────────────────┤
│  CameraX API                │  Sample Images                     │
│  - Camera Hardware          │  - Static Frames                  │
│  - Frame Capture            │  - Demo Data                      │
│  - Image Analysis           │  - Simulation                     │
└─────────────────────────────────────────────────────────────────┘
```

## 📦 Module Dependencies

```
┌─────────────────────────────────────────────────────────────────┐
│                      ANDROID MODULES                             │
└─────────────────────────────────────────────────────────────────┘

MainActivity.java
    ├── depends on → EdgeDetectionRenderer.java
    ├── depends on → native-lib.cpp (via JNI)
    ├── uses → CameraX API
    └── uses → Android SDK

EdgeDetectionRenderer.java
    ├── depends on → OpenGL ES 2.0
    └── uses → Android SDK

native-lib.cpp
    ├── depends on → opencv_processor.cpp
    └── uses → JNI

opencv_processor.cpp
    ├── depends on → opencv_processor.h
    └── uses → OpenCV C++ Library

┌─────────────────────────────────────────────────────────────────┐
│                       WEB MODULES                                │
└─────────────────────────────────────────────────────────────────┘

index.html
    └── depends on → viewer.ts (compiled to viewer.js)

viewer.ts
    └── uses → Canvas API, TypeScript
```

## 🎯 File Purpose Quick Reference

### Core Application Files
| File | Purpose | Language |
|------|---------|----------|
| MainActivity.java | Camera & UI management | Java |
| EdgeDetectionRenderer.java | OpenGL rendering | Java |
| native-lib.cpp | JNI bridge | C++ |
| opencv_processor.cpp | Image processing | C++ |
| opencv_processor.h | Processor interface | C++ |

### Web Viewer Files
| File | Purpose | Language |
|------|---------|----------|
| index.html | Web interface | HTML |
| viewer.ts | Viewer logic | TypeScript |
| viewer.js | Compiled output | JavaScript |

### Configuration Files
| File | Purpose |
|------|---------|
| build.gradle | Android build config |
| CMakeLists.txt | Native build config |
| package.json | npm configuration |
| tsconfig.json | TypeScript config |
| local.properties.template | OpenCV path template |

### Documentation Files
| File | Purpose |
|------|---------|
| START_HERE.md | Project overview |
| README.md | Main documentation |
| SETUP.md | Setup instructions |
| ARCHITECTURE.md | Technical details |
| GIT_STRATEGY.md | Git guidelines |
| PROJECT_SUMMARY.md | Assessment summary |
| SUBMISSION_CHECKLIST.md | Submission guide |

## 🔍 Where to Find Things

### Need to modify camera settings?
→ `app/src/main/java/com/flam/edgeDetection/MainActivity.java`

### Need to change edge detection parameters?
→ `app/src/main/cpp/opencv_processor.cpp`

### Need to modify OpenGL rendering?
→ `app/src/main/java/com/flam/edgeDetection/EdgeDetectionRenderer.java`

### Need to update web viewer?
→ `web/src/viewer.ts`

### Need to configure OpenCV path?
→ `local.properties` and `app/src/main/cpp/CMakeLists.txt`

### Need to modify UI layout?
→ `app/src/main/res/layout/activity_main.xml`

### Need to change app permissions?
→ `app/src/main/AndroidManifest.xml`

## 📊 Lines of Code Statistics

```
Android Java:        ~800 lines
Native C++:          ~300 lines
TypeScript:          ~400 lines
XML (Resources):     ~200 lines
Documentation:      ~3000 lines
Configuration:       ~100 lines
─────────────────────────────────
Total:              ~4800 lines
```

## 🎯 Next Steps

1. **Understand the structure** → Review this file
2. **Read documentation** → See DOCUMENTATION_INDEX.md
3. **Setup project** → Follow SETUP.md
4. **Build and test** → Use quickstart scripts
5. **Submit** → Use SUBMISSION_CHECKLIST.md

---

**This visualization helps you understand where everything is and how it connects!**



