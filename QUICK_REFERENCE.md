# 📋 Quick Reference Card

## 🚀 Essential Commands

### Setup
```bash
# Quick setup (Windows)
quickstart.bat

# Quick setup (Linux/Mac)
chmod +x quickstart.sh && ./quickstart.sh

# Initialize Git (Windows)
init-git.bat

# Initialize Git (Linux/Mac)
chmod +x init-git.sh && ./init-git.sh
```

### Build Web Viewer
```bash
cd web
npm install
npm run build
```

### Git Commands
```bash
# Initialize repository
git init

# Add all files
git add .

# Commit changes
git commit -m "Your message"

# Add remote
git remote add origin <your-repo-url>

# Push to remote
git push -u origin main
```

## 📁 Key Files

### Must Configure
- `local.properties` - OpenCV SDK path
- `app/src/main/cpp/CMakeLists.txt` - OpenCV path

### Must Read
- `START_HERE.md` - Project overview
- `SETUP.md` - Setup instructions
- `SUBMISSION_CHECKLIST.md` - Before submitting

### Source Code
- `app/src/main/java/.../MainActivity.java` - Main activity
- `app/src/main/java/.../EdgeDetectionRenderer.java` - OpenGL
- `app/src/main/cpp/opencv_processor.cpp` - OpenCV
- `web/src/viewer.ts` - Web viewer

## 🔧 Configuration

### local.properties
```properties
sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
ndk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529
opencv.dir=C\:\\path\\to\\opencv-android-sdk
```

### CMakeLists.txt
```cmake
set(OpenCV_DIR "C:/path/to/opencv-android-sdk/sdk/native/jni")
find_package(OpenCV REQUIRED)
```

## 📊 Project Structure

```
Flam assignment/
├── app/                    # Android app
│   ├── src/main/java/     # Java code
│   ├── src/main/cpp/      # C++ code
│   └── src/main/res/      # Resources
├── web/                    # Web viewer
│   ├── src/viewer.ts      # TypeScript
│   └── index.html         # HTML
└── *.md                    # Documentation
```

## ✅ Checklist

### Before Building
- [ ] OpenCV SDK downloaded
- [ ] local.properties configured
- [ ] CMakeLists.txt updated
- [ ] NDK installed
- [ ] CMake installed

### Before Submitting
- [ ] App builds successfully
- [ ] App runs on device/emulator
- [ ] Web viewer builds
- [ ] Git repository initialized
- [ ] Commits are logical
- [ ] Screenshots added
- [ ] Repository pushed
- [ ] Repository accessible

## 🎯 Quick Start (30 minutes)

1. **Download OpenCV** (5 min)
   - Visit https://opencv.org/releases/
   - Download Android SDK

2. **Configure Paths** (5 min)
   - Copy local.properties.template
   - Update paths

3. **Build Android** (10 min)
   - Open in Android Studio
   - Install NDK/CMake
   - Build and run

4. **Build Web** (2 min)
   - cd web
   - npm install && npm run build

5. **Initialize Git** (5 min)
   - Run init-git.sh/bat

6. **Add Screenshots** (2 min)
   - Take screenshots
   - Update README

7. **Push & Submit** (1 min)
   - git push
   - Submit URL

## 📚 Documentation Map

| Need | Read |
|------|------|
| Overview | START_HERE.md |
| Setup | SETUP.md |
| Architecture | ARCHITECTURE.md |
| Git | GIT_STRATEGY.md |
| Submission | SUBMISSION_CHECKLIST.md |
| All docs | DOCUMENTATION_INDEX.md |

## 🆘 Troubleshooting

### OpenCV Not Found
→ Check paths in local.properties and CMakeLists.txt

### NDK Build Error
→ Install NDK via Android Studio SDK Manager

### Low FPS
→ Test on physical device, not emulator

### Camera Permission
→ Grant permission in app settings

### Web Build Error
→ Run `npm install` first

## 🔗 Important Links

- OpenCV: https://opencv.org/releases/
- Android Studio: https://developer.android.com/studio
- Node.js: https://nodejs.org/

## 💡 Tips

- Read START_HERE.md first
- Use automation scripts
- Test incrementally
- Commit logically
- Document issues
- Add screenshots
- Verify access

## 📞 Help

- Setup issues → SETUP.md
- Architecture → ARCHITECTURE.md
- Git → GIT_STRATEGY.md
- General → START_HERE.md

---

**Keep this card handy during setup and submission!**



