#!/bin/bash

# Git Repository Initialization Script
# This script helps you initialize the Git repository with proper commits

echo "=========================================="
echo "Git Repository Initialization"
echo "=========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're already in a git repository
if [ -d ".git" ]; then
    echo "Warning: This directory is already a Git repository."
    read -p "Do you want to continue? This will NOT reinitialize. (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo "Initializing Git repository..."
    git init
    echo "✓ Git repository initialized"
    echo ""
fi

# Configure git user if not set
if [ -z "$(git config user.name)" ]; then
    read -p "Enter your name for Git commits: " git_name
    git config user.name "$git_name"
fi

if [ -z "$(git config user.email)" ]; then
    read -p "Enter your email for Git commits: " git_email
    git config user.email "$git_email"
fi

echo ""
echo "Git user: $(git config user.name) <$(git config user.email)>"
echo ""

# Ask if user wants to make commits now
echo "Would you like to create the initial commits now?"
echo "This will create a series of logical commits following best practices."
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Skipping commits. You can commit manually later."
    exit 0
fi

echo ""
echo "Creating commits..."
echo ""

# Commit 1: Documentation
git add README.md SETUP.md ARCHITECTURE.md GIT_STRATEGY.md PROJECT_SUMMARY.md SUBMISSION_CHECKLIST.md .gitignore
git commit -m "docs: Add comprehensive project documentation

- Add main README with features and setup instructions
- Add detailed SETUP guide with troubleshooting
- Add ARCHITECTURE documentation with technical details
- Add GIT_STRATEGY for version control guidelines
- Add PROJECT_SUMMARY for assessment overview
- Add SUBMISSION_CHECKLIST for final review
- Configure .gitignore for Android and Node.js"

echo "✓ Commit 1: Documentation"

# Commit 2: Build configuration
git add gradle.properties settings.gradle build.gradle local.properties.template quickstart.sh quickstart.bat
git commit -m "chore: Add Gradle build configuration and setup scripts

- Configure Gradle properties and settings
- Add root build.gradle
- Add local.properties template for OpenCV path
- Add quick start scripts for easy setup"

echo "✓ Commit 2: Build configuration"

# Commit 3: Android app module
git add app/build.gradle app/proguard-rules.pro
git commit -m "chore: Configure Android app module with NDK support

- Add app-level build.gradle with NDK configuration
- Configure CMake for native build
- Add ProGuard rules for native methods
- Add CameraX dependencies"

echo "✓ Commit 3: Android app module"

# Commit 4: Android manifest and resources
git add app/src/main/AndroidManifest.xml app/src/main/res/
git commit -m "feat(android): Add Android manifest and resources

- Add manifest with camera permissions
- Add layouts for main activity
- Add strings, colors, and themes
- Configure material design theme"

echo "✓ Commit 4: Android manifest and resources"

# Commit 5: MainActivity
git add app/src/main/java/com/flam/edgeDetection/MainActivity.java
git commit -m "feat(camera): Implement camera integration with CameraX

- Add MainActivity with camera lifecycle management
- Implement camera permission handling
- Setup ImageAnalysis for frame processing
- Add FPS counter and statistics display
- Implement toggle between raw and processed views"

echo "✓ Commit 5: MainActivity"

# Commit 6: OpenGL Renderer
git add app/src/main/java/com/flam/edgeDetection/EdgeDetectionRenderer.java
git commit -m "feat(opengl): Implement OpenGL ES 2.0 renderer

- Add EdgeDetectionRenderer with shader support
- Implement vertex and fragment shaders
- Add texture management and updates
- Configure MVP matrix transformations
- Optimize for real-time rendering"

echo "✓ Commit 6: OpenGL Renderer"

# Commit 7: CMake configuration
git add app/src/main/cpp/CMakeLists.txt
git commit -m "chore(native): Add CMake build configuration

- Configure CMake for C++ compilation
- Add OpenCV library linking
- Setup include directories
- Configure native library build"

echo "✓ Commit 7: CMake configuration"

# Commit 8: OpenCV processor header
git add app/src/main/cpp/opencv_processor.h
git commit -m "feat(opencv): Add OpenCV processor header

- Define OpenCVProcessor class interface
- Add method declarations for frame processing
- Setup initialization and cleanup methods"

echo "✓ Commit 8: OpenCV processor header"

# Commit 9: OpenCV processor implementation
git add app/src/main/cpp/opencv_processor.cpp
git commit -m "feat(opencv): Implement Canny edge detection processing

- Implement OpenCV processor with Canny algorithm
- Add YUV to RGB conversion
- Add Gaussian blur pre-processing
- Optimize for real-time performance
- Add error handling and logging"

echo "✓ Commit 9: OpenCV processor"

# Commit 10: JNI bridge
git add app/src/main/cpp/native-lib.cpp
git commit -m "feat(jni): Implement JNI bridge for Java-C++ communication

- Add JNI method implementations
- Setup data marshalling between Java and C++
- Add OpenCV processor lifecycle management
- Implement efficient memory handling"

echo "✓ Commit 10: JNI bridge"

# Commit 11: Web viewer setup
git add web/package.json web/tsconfig.json web/README.md
git commit -m "chore(web): Setup TypeScript project configuration

- Add package.json with dependencies
- Configure TypeScript compiler options
- Add build and development scripts
- Add web viewer documentation"

echo "✓ Commit 11: Web viewer setup"

# Commit 12: Web viewer HTML
git add web/index.html
git commit -m "feat(web): Create web viewer HTML interface

- Add modern, responsive HTML layout
- Implement gradient design with glassmorphism
- Add canvas elements for frame display
- Add statistics panel and controls
- Optimize for mobile and desktop"

echo "✓ Commit 12: Web viewer HTML"

# Commit 13: Web viewer TypeScript
git add web/src/viewer.ts
git commit -m "feat(web): Implement TypeScript viewer with canvas rendering

- Add EdgeDetectionViewer class
- Implement canvas-based frame rendering
- Add simulation mode for demonstration
- Add frame export functionality
- Add statistics tracking and display
- Implement sample image generation"

echo "✓ Commit 13: Web viewer TypeScript"

echo ""
echo "=========================================="
echo "Git repository initialized successfully!"
echo "=========================================="
echo ""
echo "Total commits: 13"
echo ""
echo "Next steps:"
echo "1. Create a repository on GitHub or GitLab"
echo "2. Add remote: git remote add origin <your-repo-url>"
echo "3. Push commits: git push -u origin main"
echo ""
echo "View commit history: git log --oneline --graph"
echo ""



