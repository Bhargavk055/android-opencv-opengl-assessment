@echo off
REM Git Repository Initialization Script (Windows)
REM This script helps you initialize the Git repository with proper commits

echo ==========================================
echo Git Repository Initialization
echo ==========================================
echo.

REM Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: Git is not installed. Please install Git first.
    exit /b 1
)

REM Check if we're already in a git repository
if exist ".git" (
    echo Warning: This directory is already a Git repository.
    set /p continue="Do you want to continue? (y/n): "
    if /i not "%continue%"=="y" exit /b 1
) else (
    echo Initializing Git repository...
    git init
    echo √ Git repository initialized
    echo.
)

REM Check git user configuration
for /f "tokens=*" %%i in ('git config user.name') do set git_name=%%i
if "%git_name%"=="" (
    set /p git_name="Enter your name for Git commits: "
    git config user.name "%git_name%"
)

for /f "tokens=*" %%i in ('git config user.email') do set git_email=%%i
if "%git_email%"=="" (
    set /p git_email="Enter your email for Git commits: "
    git config user.email "%git_email%"
)

for /f "tokens=*" %%i in ('git config user.name') do set git_name=%%i
for /f "tokens=*" %%i in ('git config user.email') do set git_email=%%i
echo.
echo Git user: %git_name% ^<%git_email%^>
echo.

REM Ask if user wants to make commits now
set /p make_commits="Would you like to create the initial commits now? (y/n): "
if /i not "%make_commits%"=="y" (
    echo Skipping commits. You can commit manually later.
    exit /b 0
)

echo.
echo Creating commits...
echo.

REM Commit 1: Documentation
git add README.md SETUP.md ARCHITECTURE.md GIT_STRATEGY.md PROJECT_SUMMARY.md SUBMISSION_CHECKLIST.md .gitignore
git commit -m "docs: Add comprehensive project documentation" -m "- Add main README with features and setup instructions" -m "- Add detailed SETUP guide with troubleshooting" -m "- Add ARCHITECTURE documentation with technical details" -m "- Add GIT_STRATEGY for version control guidelines" -m "- Add PROJECT_SUMMARY for assessment overview" -m "- Add SUBMISSION_CHECKLIST for final review" -m "- Configure .gitignore for Android and Node.js"
echo √ Commit 1: Documentation

REM Commit 2: Build configuration
git add gradle.properties settings.gradle build.gradle local.properties.template quickstart.sh quickstart.bat
git commit -m "chore: Add Gradle build configuration and setup scripts" -m "- Configure Gradle properties and settings" -m "- Add root build.gradle" -m "- Add local.properties template for OpenCV path" -m "- Add quick start scripts for easy setup"
echo √ Commit 2: Build configuration

REM Commit 3: Android app module
git add app\build.gradle app\proguard-rules.pro
git commit -m "chore: Configure Android app module with NDK support" -m "- Add app-level build.gradle with NDK configuration" -m "- Configure CMake for native build" -m "- Add ProGuard rules for native methods" -m "- Add CameraX dependencies"
echo √ Commit 3: Android app module

REM Commit 4: Android manifest and resources
git add app\src\main\AndroidManifest.xml app\src\main\res\
git commit -m "feat(android): Add Android manifest and resources" -m "- Add manifest with camera permissions" -m "- Add layouts for main activity" -m "- Add strings, colors, and themes" -m "- Configure material design theme"
echo √ Commit 4: Android manifest and resources

REM Commit 5: MainActivity
git add app\src\main\java\com\flam\edgeDetection\MainActivity.java
git commit -m "feat(camera): Implement camera integration with CameraX" -m "- Add MainActivity with camera lifecycle management" -m "- Implement camera permission handling" -m "- Setup ImageAnalysis for frame processing" -m "- Add FPS counter and statistics display" -m "- Implement toggle between raw and processed views"
echo √ Commit 5: MainActivity

REM Commit 6: OpenGL Renderer
git add app\src\main\java\com\flam\edgeDetection\EdgeDetectionRenderer.java
git commit -m "feat(opengl): Implement OpenGL ES 2.0 renderer" -m "- Add EdgeDetectionRenderer with shader support" -m "- Implement vertex and fragment shaders" -m "- Add texture management and updates" -m "- Configure MVP matrix transformations" -m "- Optimize for real-time rendering"
echo √ Commit 6: OpenGL Renderer

REM Commit 7: CMake configuration
git add app\src\main\cpp\CMakeLists.txt
git commit -m "chore(native): Add CMake build configuration" -m "- Configure CMake for C++ compilation" -m "- Add OpenCV library linking" -m "- Setup include directories" -m "- Configure native library build"
echo √ Commit 7: CMake configuration

REM Commit 8: OpenCV processor header
git add app\src\main\cpp\opencv_processor.h
git commit -m "feat(opencv): Add OpenCV processor header" -m "- Define OpenCVProcessor class interface" -m "- Add method declarations for frame processing" -m "- Setup initialization and cleanup methods"
echo √ Commit 8: OpenCV processor header

REM Commit 9: OpenCV processor implementation
git add app\src\main\cpp\opencv_processor.cpp
git commit -m "feat(opencv): Implement Canny edge detection processing" -m "- Implement OpenCV processor with Canny algorithm" -m "- Add YUV to RGB conversion" -m "- Add Gaussian blur pre-processing" -m "- Optimize for real-time performance" -m "- Add error handling and logging"
echo √ Commit 9: OpenCV processor

REM Commit 10: JNI bridge
git add app\src\main\cpp\native-lib.cpp
git commit -m "feat(jni): Implement JNI bridge for Java-C++ communication" -m "- Add JNI method implementations" -m "- Setup data marshalling between Java and C++" -m "- Add OpenCV processor lifecycle management" -m "- Implement efficient memory handling"
echo √ Commit 10: JNI bridge

REM Commit 11: Web viewer setup
git add web\package.json web\tsconfig.json web\README.md
git commit -m "chore(web): Setup TypeScript project configuration" -m "- Add package.json with dependencies" -m "- Configure TypeScript compiler options" -m "- Add build and development scripts" -m "- Add web viewer documentation"
echo √ Commit 11: Web viewer setup

REM Commit 12: Web viewer HTML
git add web\index.html
git commit -m "feat(web): Create web viewer HTML interface" -m "- Add modern, responsive HTML layout" -m "- Implement gradient design with glassmorphism" -m "- Add canvas elements for frame display" -m "- Add statistics panel and controls" -m "- Optimize for mobile and desktop"
echo √ Commit 12: Web viewer HTML

REM Commit 13: Web viewer TypeScript
git add web\src\viewer.ts
git commit -m "feat(web): Implement TypeScript viewer with canvas rendering" -m "- Add EdgeDetectionViewer class" -m "- Implement canvas-based frame rendering" -m "- Add simulation mode for demonstration" -m "- Add frame export functionality" -m "- Add statistics tracking and display" -m "- Implement sample image generation"
echo √ Commit 13: Web viewer TypeScript

REM Commit 14: Git initialization scripts
git add init-git.sh init-git.bat
git commit -m "chore: Add Git initialization scripts" -m "- Add bash script for Linux/Mac" -m "- Add batch script for Windows" -m "- Automate repository setup" -m "- Create logical commit sequence"
echo √ Commit 14: Git initialization scripts

echo.
echo ==========================================
echo Git repository initialized successfully!
echo ==========================================
echo.
echo Total commits: 14
echo.
echo Next steps:
echo 1. Create a repository on GitHub or GitLab
echo 2. Add remote: git remote add origin ^<your-repo-url^>
echo 3. Push commits: git push -u origin main
echo.
echo View commit history: git log --oneline --graph
echo.

pause



