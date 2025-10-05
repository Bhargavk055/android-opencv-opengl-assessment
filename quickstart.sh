#!/bin/bash

# Edge Detection Project - Quick Start Script
# This script helps you get started with the project quickly

echo "=========================================="
echo "Edge Detection Project - Quick Start"
echo "=========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "settings.gradle" ]; then
    echo "Error: Please run this script from the project root directory"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "Checking prerequisites..."
echo ""

# Check Node.js
if command_exists node; then
    NODE_VERSION=$(node --version)
    echo "✓ Node.js found: $NODE_VERSION"
else
    echo "✗ Node.js not found. Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    echo "✓ npm found: $NPM_VERSION"
else
    echo "✗ npm not found. Please install npm"
    exit 1
fi

echo ""
echo "=========================================="
echo "Setting up Web Viewer"
echo "=========================================="
echo ""

# Setup web viewer
cd web
echo "Installing dependencies..."
npm install

echo "Building TypeScript..."
npm run build

if [ $? -eq 0 ]; then
    echo "✓ Web viewer built successfully"
else
    echo "✗ Web viewer build failed"
    exit 1
fi

cd ..

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Android App:"
echo "   - Open the project in Android Studio"
echo "   - Configure OpenCV SDK path in local.properties"
echo "   - Build and run on device/emulator"
echo ""
echo "2. Web Viewer:"
echo "   - Open web/index.html in a browser"
echo "   - Or run: cd web && python -m http.server 8080"
echo "   - Then visit: http://localhost:8080"
echo ""
echo "For detailed setup instructions, see SETUP.md"
echo ""



