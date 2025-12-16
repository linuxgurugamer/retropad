# Release Process Guide for retropad

## Quick Start

Build and package a release:
```batch
release-build.bat 1.1.0
```

This creates `release/retropad-1.1.0.zip` with the executable and documentation.

---

## Detailed Release Checklist

### 1. Code Preparation
- [ ] All features complete and tested
- [ ] All bugs fixed and verified
- [ ] Code reviewed by team
- [ ] No open issues blocking release
- [ ] No compiler warnings or errors
- [ ] Unit tests passing (if applicable)

### 2. Documentation Updates
- [ ] Update `CHANGELOG.md` with new version, date, and changes
- [ ] Update `README.md` if there are new features or requirements
- [ ] Create release notes in `release/release-notes-X.Y.Z.md`
- [ ] Update version in `version.bat`
- [ ] Update `resource.h` version constants if needed

### 3. Version Bump
Edit the following files:

**CMakeLists.txt:**
```cmake
project(retropad VERSION 1.1.0 LANGUAGES C RC)
```

**version.bat:**
```batch
@set VERSION_MAJOR=1
@set VERSION_MINOR=1
@set VERSION_PATCH=0
```

**retropad.rc (optional):**
```rc
FILEVERSION 1,1,0,0
PRODUCTVERSION 1,1,0,0
```

### 4. Build Release Package

```batch
release-build.bat 1.1.0
```

The script will:
- Clean previous builds
- Build Release configuration (optimized, with debug symbols)
- Create package directory: `release/retropad-1.1.0/`
- Include: executable, README, LICENSE, RELEASE_NOTES.txt
- Create ZIP: `release/retropad-1.1.0.zip`
- Generate SHA256 hash for security verification

### 5. Test Release Package

**On development machine:**
```batch
REM Extract and test
mkdir test-release
cd test-release
powershell -Command "Expand-Archive '..\release\retropad-1.1.0.zip' ."
cd retropad-1.1.0
retropad.exe
```

**Test checklist:**
- [ ] Executable runs without errors
- [ ] All menus accessible
- [ ] File Open/Save works
- [ ] Find/Replace functional
- [ ] Settings dialog opens and saves
- [ ] Word wrap toggles correctly
- [ ] Status bar appears/disappears appropriately
- [ ] Font picker works
- [ ] Time/Date insertion works
- [ ] Drag-and-drop file open works
- [ ] No runtime errors or crashes

**On clean test machine (if possible):**
- [ ] Extract ZIP on machine without development tools
- [ ] Run executable directly
- [ ] Verify no missing DLL dependencies
- [ ] Test basic workflow

### 6. Git Workflow

```batch
REM Commit release changes
git add CHANGELOG.md README.md version.bat CMakeLists.txt retropad.rc
git commit -m "Release: retropad v1.1.0"

REM Create annotated tag
git tag -a v1.1.0 -m "Release version 1.1.0 - [Brief description]"

REM Push to remote
git push origin main
git push origin v1.1.0
```

### 7. GitHub Release

1. Go to: https://github.com/Alt3rnativity/retropad/releases
2. Click "Draft a new release"
3. **Tag version:** `v1.1.0`
4. **Release title:** `retropad v1.1.0`
5. **Description:** Use CHANGELOG.md entry and release notes
6. **Attach files:**
  - `release/retropad-1.1.0.zip`
  - `release/retropad-1.1.0/RELEASE_NOTES.txt`
7. **Pre-release?** Check if beta/RC, uncheck for stable
8. Click "Publish release"

### 8. Post-Release

- [ ] Verify GitHub release appears correctly
- [ ] Test download from GitHub
- [ ] Update project website if applicable
- [ ] Announce on social media/forums if applicable
- [ ] Monitor for bug reports

---

## Build Configurations

### Development Build
```batch
build-cmake.bat
```
- Debug symbols included
- Optimizations disabled
- Useful for debugging
- Output: `build/bin/Debug/retropad.exe`

### Release Build
```batch
release-build.bat X.Y.Z
```
- Optimizations enabled (`/O2`)
- Debug symbols included (for crash dumps)
- No runtime checks
- Smaller binary
- Output: `release/retropad-X.Y.Z/retropad.exe`

### Custom Build (Advanced)

```batch
mkdir build
cd build
cmake -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release
```

---

## File Artifacts

After running `release-build.bat 1.1.0`:

```
release/
├── retropad-1.1.0.zip          ← ZIP package for distribution
└── retropad-1.1.0/             ← Uncompressed release directory
    ├── retropad.exe            ← Main executable
    ├── README.md               ← Project documentation
    ├── LICENSE                 ← License file
```

---

## Version Numbering (Semantic Versioning)

Format: `MAJOR.MINOR.PATCH`

- **MAJOR:** Incompatible changes, breaking API changes
- **MINOR:** Backward-compatible features, enhancements
- **PATCH:** Backward-compatible bug fixes

Example progression:
- `1.0.0` → `1.0.1` (bug fix)
- `1.0.1` → `1.1.0` (new feature)
- `1.1.0` → `2.0.0` (breaking change)

---

## Troubleshooting

### Build fails with RC compiler error
- Ensure RC.exe is in PATH
- Check retropad.rc syntax
- Verify resource.h constants match RC file usage

### ZIP creation fails
- Ensure PowerShell is available
- Try manual ZIP creation: use 7-Zip or Windows Explorer's built-in ZIP
- Check disk space

### Version mismatch between files
- Update all version locations:
  - CMakeLists.txt
  - version.bat
  - retropad.rc
  - CHANGELOG.md
  - Release notes

### Missing dependencies in release package
- Use `depends.exe` or similar tool to check DLL dependencies
- Note that MSVC runtime should be installed via Windows Update
- Consider statically linking if possible

---

## Continuous Integration (Optional)

For automated releases, consider:

1. **GitHub Actions workflow** (`.github/workflows/release.yml`)
   - Triggered on version tag
   - Builds automatically
   - Creates release with artifacts

2. **AppVeyor** for Windows builds
   - Separate build for each commit
   - Automatic artifact staging

Example GitHub Actions workflow in `.github/workflows/release.yml`:

```yaml
name: Release Build
on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build release
        run: release-build.bat ${GITHUB_REF#refs/tags/v}
      - name: Upload artifacts
        uses: softprops/action-gh-release@v1
        with:
          files: release/retropad-*.zip
```

---

**Last Updated:** December 7, 2025
