# Git Commit Strategy

This document outlines the commit strategy used for this project to demonstrate proper version control practices.

## Commit Structure

### Initial Setup Commits
```bash
git init
git add README.md .gitignore
git commit -m "Initial commit: Project setup and documentation"

git add gradle.properties settings.gradle build.gradle
git commit -m "Add Gradle build configuration"

git add app/build.gradle app/proguard-rules.pro
git commit -m "Configure Android app module with NDK support"
```

### Android Application Commits
```bash
git add app/src/main/AndroidManifest.xml
git commit -m "Add Android manifest with camera permissions"

git add app/src/main/res/
git commit -m "Add Android resources (layouts, strings, colors, themes)"

git add app/src/main/java/com/flam/edgeDetection/MainActivity.java
git commit -m "Implement MainActivity with camera integration"

git add app/src/main/java/com/flam/edgeDetection/EdgeDetectionRenderer.java
git commit -m "Implement OpenGL ES 2.0 renderer for frame display"
```

### Native Code Commits
```bash
git add app/src/main/cpp/CMakeLists.txt
git commit -m "Add CMake build configuration for native code"

git add app/src/main/cpp/opencv_processor.h
git commit -m "Add OpenCV processor header file"

git add app/src/main/cpp/opencv_processor.cpp
git commit -m "Implement OpenCV edge detection processing"

git add app/src/main/cpp/native-lib.cpp
git commit -m "Implement JNI bridge for Java-C++ communication"
```

### Web Viewer Commits
```bash
git add web/package.json web/tsconfig.json
git commit -m "Setup TypeScript project configuration"

git add web/index.html
git commit -m "Create web viewer HTML interface"

git add web/src/viewer.ts
git commit -m "Implement TypeScript viewer with canvas rendering"
```

### Documentation Commits
```bash
git add SETUP.md
git commit -m "Add comprehensive setup instructions"

git add ARCHITECTURE.md
git commit -m "Add detailed architecture documentation"

git add web/README.md
git commit -m "Add web viewer documentation"

git add README.md
git commit -m "Update main README with features and screenshots"
```

## Commit Message Guidelines

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding tests
- **chore**: Build process or auxiliary tool changes

### Examples

#### Feature Commit
```
feat(camera): Add CameraX integration for frame capture

- Implement camera permission handling
- Setup ImageAnalysis use case
- Add frame processing pipeline
- Configure camera executor thread

Closes #1
```

#### Fix Commit
```
fix(opengl): Resolve texture memory leak

- Release texture resources properly
- Add cleanup in onDestroy
- Fix buffer allocation issue

Fixes #5
```

#### Documentation Commit
```
docs(readme): Add setup instructions and architecture overview

- Include OpenCV SDK installation steps
- Document NDK configuration
- Add troubleshooting section
```

## Branch Strategy

### Main Branches
- `main`: Production-ready code
- `develop`: Development branch

### Feature Branches
- `feature/camera-integration`
- `feature/opencv-processing`
- `feature/opengl-renderer`
- `feature/web-viewer`

### Workflow
```bash
# Create feature branch
git checkout -b feature/camera-integration

# Make changes and commit
git add .
git commit -m "feat(camera): Implement camera integration"

# Push to remote
git push origin feature/camera-integration

# Create pull request
# After review, merge to develop
git checkout develop
git merge feature/camera-integration

# Delete feature branch
git branch -d feature/camera-integration
```

## Recommended Commit Sequence

### Day 1: Project Setup and Android Foundation
1. Initial project structure
2. Gradle configuration
3. Android manifest and resources
4. MainActivity skeleton
5. Camera integration

### Day 2: Native Processing and OpenGL
6. CMake configuration
7. OpenCV processor implementation
8. JNI bridge
9. OpenGL renderer
10. Integration testing

### Day 3: Web Viewer and Documentation
11. TypeScript project setup
12. Web viewer implementation
13. Documentation (README, SETUP, ARCHITECTURE)
14. Final testing and polish
15. Screenshots and demo

## Git Commands Reference

### Basic Commands
```bash
# Initialize repository
git init

# Add files
git add <file>
git add .

# Commit changes
git commit -m "message"

# Push to remote
git push origin main

# Pull from remote
git pull origin main

# Check status
git status

# View commit history
git log --oneline --graph
```

### Advanced Commands
```bash
# Amend last commit
git commit --amend

# Interactive rebase
git rebase -i HEAD~3

# Cherry-pick commit
git cherry-pick <commit-hash>

# Stash changes
git stash
git stash pop

# Tag release
git tag -a v1.0 -m "Release version 1.0"
git push origin v1.0
```

## Best Practices

1. **Commit Often**: Make small, focused commits
2. **Write Clear Messages**: Explain what and why, not how
3. **Test Before Commit**: Ensure code builds and runs
4. **Keep Commits Atomic**: One logical change per commit
5. **Use Branches**: Don't commit directly to main
6. **Review Before Push**: Check diff before pushing
7. **Sign Commits**: Use GPG signing for security

## Pre-commit Checklist

- [ ] Code compiles without errors
- [ ] No linter warnings
- [ ] Tests pass (if applicable)
- [ ] Documentation updated
- [ ] Commit message is clear and descriptive
- [ ] No sensitive data (API keys, passwords)
- [ ] Files properly formatted

## Example Commit History

```
* 15a3c2f (HEAD -> main) docs: Add comprehensive documentation
* 8b4d9e1 feat(web): Implement TypeScript web viewer
* 7c2a1f0 feat(opengl): Add OpenGL ES 2.0 renderer
* 6d1b8c9 feat(opencv): Implement edge detection processing
* 5e0a7b8 feat(jni): Add JNI bridge for native communication
* 4f9c6a7 feat(camera): Implement camera integration
* 3e8b5d6 chore: Configure Android app module
* 2d7a4c5 chore: Add Gradle build configuration
* 1c6b3a4 Initial commit: Project setup
```



