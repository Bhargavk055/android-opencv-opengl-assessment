@echo off
REM Edge Detection Project - Quick Start Script (Windows)
REM This script helps you get started with the project quickly

echo ==========================================
echo Edge Detection Project - Quick Start
echo ==========================================
echo.

REM Check if we're in the right directory
if not exist "settings.gradle" (
    echo Error: Please run this script from the project root directory
    exit /b 1
)

REM Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo X Node.js not found. Please install Node.js from https://nodejs.org/
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo √ Node.js found: %NODE_VERSION%
)

REM Check npm
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo X npm not found. Please install npm
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo √ npm found: %NPM_VERSION%
)

echo.
echo ==========================================
echo Setting up Web Viewer
echo ==========================================
echo.

REM Setup web viewer
cd web
echo Installing dependencies...
call npm install

echo Building TypeScript...
call npm run build

if %ERRORLEVEL% EQU 0 (
    echo √ Web viewer built successfully
) else (
    echo X Web viewer build failed
    exit /b 1
)

cd ..

echo.
echo ==========================================
echo Setup Complete!
echo ==========================================
echo.
echo Next steps:
echo.
echo 1. Android App:
echo    - Open the project in Android Studio
echo    - Configure OpenCV SDK path in local.properties
echo    - Build and run on device/emulator
echo.
echo 2. Web Viewer:
echo    - Open web\index.html in a browser
echo    - Or run: cd web ^&^& python -m http.server 8080
echo    - Then visit: http://localhost:8080
echo.
echo For detailed setup instructions, see SETUP.md
echo.

pause



