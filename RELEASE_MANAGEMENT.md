# retropad Release Management

## Overview

The retropad project includes a complete release management system with automated build scripting, version control, and packaging.

## Release System Components

### 1. **version.bat** - Version Configuration
Central version information source:
```batch
@set VERSION_MAJOR=1
@set VERSION_MINOR=0
@set VERSION_PATCH=0
```

Update this file for each release, then reference VERSION variables in other build scripts.

### 2. **release-build.bat** - Automated Build & Package
One-command release process:
```batch
release-build.bat 1.0.0
```

**What it does:**
- Cleans previous build artifacts
- Builds Release configuration (optimized, with debug info)
- Creates organized release directory
- Copies executable and documentation
- Packages as ZIP archive
- Generates SHA256 hash for verification

**Output:**
```
release/
├── retropad-1.0.0.zip          (distribution package)
└── retropad-1.0.0/             (unpacked directory)
    ├── retropad.exe            (executable)
    ├── README.md               (documentation)
    ├── LICENSE                 (if exists)
    └── RELEASE_NOTES.txt       (auto-generated)
```

### 3. **CHANGELOG.md** - Version History
Documents all changes per version following Keep a Changelog format:
- Added features
- Fixed bugs
- Breaking changes
- Known issues

Update before each release.

### 4. **RELEASE_PROCESS.md** - Step-by-Step Guide
Comprehensive checklist including:
- Code preparation steps
- Documentation updates
- Version bumping procedure
- Testing instructions
- Git workflow
- GitHub release creation
- Post-release validation

### 5. **GitHub Actions Workflow** (Optional CI/CD)
Automatic release builds on tag push:
```
.github/workflows/release.yml.template
```

## Quick Start Guide

### For a New Release

**1. Update Version:**
```batch
REM Edit version.bat
@set VERSION_MINOR=1
```

**2. Update CHANGELOG.md:**
Add new entry with features, fixes, improvements

**3. Build Release:**
```batch
release-build.bat 1.0.1
```

**4. Test Package:**
```batch
cd release\retropad-1.0.1
retropad.exe
```

**5. Tag and Push:**
```batch
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```

**6. Create GitHub Release:**
Go to https://github.com/PlummersSoftwareLLC/retropad/releases
- Attach ZIP file
- Copy CHANGELOG entry
- Publish

## File Structure

```
retropad/
├── retropad.c                  (main UI logic)
├── file_io.c/h                 (file I/O helpers)
├── retropad.rc                 (resources)
├── resource.h                  (constants)
├── CMakeLists.txt              (build config)
├── build-cmake.bat             (development build)
├── release-build.bat           (release build) ← NEW
├── version.bat                 (version config) ← NEW
├── CHANGELOG.md                (version history) ← NEW
├── RELEASE_PROCESS.md          (release guide) ← NEW
├── README.md                   (project docs)
├── LICENSE                     (if applicable)
│
├── .github/workflows/
│   └── release.yml.template    (GitHub Actions) ← NEW
│
├── release/                    (release artifacts)
│   ├── retropad-1.0.0.zip
│   └── retropad-1.0.0/
│       ├── retropad.exe
│       ├── README.md
│       └── RELEASE_NOTES.txt
│
└── build/                      (build output)
    └── bin/
        └── Release/
            └── retropad.exe
```

## Build Configurations

### Development Build
```batch
build-cmake.bat
```
- Fast incremental builds
- Debug symbols
- Output: `build/bin/Release/retropad.exe`

### Release Build
```batch
release-build.bat 1.0.1
```
- Optimizations enabled
- Debug symbols included
- Clean rebuild
- ZIP packaging
- SHA256 hashing
- Output: `release/retropad-1.0.1.zip`

## Version Numbering

Follows Semantic Versioning (semver.org):

- **Major (X.0.0):** Breaking changes, API redesign
  - Example: 1.0.0 → 2.0.0 (removed features, incompatible changes)

- **Minor (0.Y.0):** New backward-compatible features
  - Example: 1.0.0 → 1.1.0 (new feature, all old code still works)

- **Patch (0.0.Z):** Bug fixes and minor updates
  - Example: 1.0.0 → 1.0.1 (bug fix, no new features)

### Examples
```
1.0.0 (initial release)
1.0.1 (bug fix)
1.1.0 (new feature)
1.1.1 (bug fix to v1.1.0)
2.0.0 (major rewrite)
```

## Release Checklist

Use this checklist from RELEASE_PROCESS.md:

```
Code:
  [ ] All features complete
  [ ] All tests pass
  [ ] No compiler warnings
  [ ] Code reviewed

Documentation:
  [ ] CHANGELOG.md updated
  [ ] README.md current
  [ ] Release notes created
  [ ] Version numbers consistent

Build:
  [ ] release-build.bat succeeds
  [ ] ZIP created successfully
  [ ] SHA256 hash generated

Testing:
  [ ] Extract ZIP
  [ ] Run executable
  [ ] Test all major features
  [ ] Verify no runtime errors

Release:
  [ ] Git tag created
  [ ] GitHub release created
  [ ] ZIP attached
  [ ] Notes/changelog included
```

## Common Tasks

### Build a Release
```batch
release-build.bat 1.0.1
```

### Extract and Test Release
```batch
cd release\retropad-1.0.1
retropad.exe
```

### Create Git Release Tag
```batch
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```

### View Release History
```batch
git tag -l
git show v1.0.0
```

### Update Version
1. Edit `version.bat` (VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH)
2. Update `CHANGELOG.md` with new section
3. Run `release-build.bat X.Y.Z`

## GitHub Integration

### Automatic Release (GitHub Actions)

Place workflow at `.github/workflows/release.yml`:
1. Triggers on version tag push (v1.0.0)
2. Runs `release-build.bat` automatically
3. Creates GitHub Release with ZIP attachment
4. Publishes release notes from CHANGELOG.md

**Setup:**
1. Copy `.github/workflows/release.yml.template` to `.github/workflows/release.yml`
2. Commit and push to GitHub
3. GitHub Actions will now trigger on tags

**Usage:**
```batch
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```
GitHub Actions automatically handles the rest!

### Manual GitHub Release

1. Go to: https://github.com/PlummersSoftwareLLC/retropad/releases/new
2. **Tag:** `v1.0.1`
3. **Title:** `retropad v1.0.1`
4. **Description:** Copy from CHANGELOG.md
5. **Attach:** `release/retropad-1.0.1.zip`
6. **Publish**

## Verification & Security

### SHA256 Hash Verification

Automatically generated during release:
```
SHA256: ba66a629a718e84b3fdb7f0c3df985fcfc4df33296dd6ab32afe124d9dc56667
```

Users can verify:
```batch
certutil -hashfile retropad-1.0.1.zip SHA256
```

### Test Release Package

Before publishing:
```batch
mkdir test-retropad
cd test-retropad
powershell -Command "Expand-Archive '..\release\retropad-1.0.1.zip' ."
cd retropad-1.0.1
retropad.exe
```

Verify:
- Executable runs
- All features work
- No missing files
- No errors

## Troubleshooting

### Build fails
- Check CMake is installed
- Verify Visual Studio 2022 with C++ tools
- Ensure all source files present

### ZIP creation fails
- Check PowerShell available
- Verify disk space
- Try manual ZIP with 7-Zip

### Version mismatch
- Update all version locations:
  - version.bat
  - CMakeLists.txt
  - retropad.rc
  - CHANGELOG.md
  - README.md (if needed)

### GitHub Actions not triggering
- Verify tag format: `v1.0.0` (starts with 'v')
- Check workflow file syntax
- Ensure .yml file in `.github/workflows/`

## Advanced: Custom Build

For fine-tuned control:

```batch
mkdir build
cd build
cmake -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release --parallel 4
```

## Support

For issues with the release process:
1. Check RELEASE_PROCESS.md for detailed steps
2. Review GitHub Actions logs
3. Verify version consistency
4. Check build output for errors

---

**Last Updated:** December 7, 2025
**Current Version:** 1.0.0
