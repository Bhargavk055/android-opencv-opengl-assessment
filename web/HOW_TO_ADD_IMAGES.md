# 🖼️ How to Add Your Own Images to the Edge Detection Web Viewer

## Method 1: Use the File Picker (Easiest)
1. Open `index.html` in your browser
2. Click the **"📁 Load Your Image"** button
3. Select any image file (JPG, PNG, GIF, etc.) from your computer
4. The image will be automatically loaded and processed with edge detection

## Method 2: Add Images to the Web Folder
1. Copy your image files to the `web` folder
2. Rename one of them to `sample.jpg` (or update the filename in the code)
3. Click **"📁 Load Sample Image"** to load it

## Supported Image Formats
- JPG/JPEG
- PNG
- GIF
- BMP
- WEBP

## Current Features
- ✅ Automatic image resizing to fit 640x480 canvas
- ✅ Real-time edge detection simulation
- ✅ Export processed results
- ✅ Multiple image loading options

## Tips
- For best results, use high-contrast images
- Images are automatically scaled to fit the viewer
- The edge detection is simulated using luminance gradient calculation
- You can switch between different images anytime using the file picker

## Code Files Modified
- `src/viewer.ts` - Added image loading functionality
- `index.html` - Added file input button
- All changes are automatically compiled to `dist/viewer.js`