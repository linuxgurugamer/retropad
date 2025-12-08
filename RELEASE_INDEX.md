# retropad Release System - Complete Documentation Index

## 📚 Documentation Files

### For Getting Started
1. **[RELEASE_SETUP.md](RELEASE_SETUP.md)** ← START HERE
   - Quick overview of the release system
   - One-command release process
   - File locations and structure
   - Testing checklist

### For Release Management
2. **[RELEASE_PROCESS.md](RELEASE_PROCESS.md)** - Detailed Release Checklist
   - Step-by-step release procedure
   - Code preparation
   - Documentation updates
   - Build and test instructions
   - Git workflow
   - GitHub release creation
   - Post-release validation

3. **[RELEASE_MANAGEMENT.md](RELEASE_MANAGEMENT.md)** - System Architecture & Reference
   - System components overview
   - Quick start examples
   - File structure
   - Build configurations
   - Version numbering strategy
   - Common tasks
   - GitHub Actions integration
   - Troubleshooting guide

### For Distribution & Deployment
4. **[DEPLOYMENT.md](DEPLOYMENT.md)** - Distribution & Deployment Guide
   - Distribution channels (GitHub, website, Microsoft Store, Chocolatey)
   - Installation methods
   - System requirements
   - Deployment checklist
   - Environment-specific instructions
   - Dependencies & runtime
   - Update strategy
   - Success metrics

### Version Control
5. **[CHANGELOG.md](CHANGELOG.md)** - Complete Version History
   - Unreleased changes
   - Per-version details (features, fixes, improvements)
   - Known issues
   - Release workflow guide
   - Version strategy

---

## 🔧 Configuration & Scripts

### Build & Release Scripts
- **`release-build.bat`** - One-command release packaging
  ```batch
  release-build.bat 1.0.1
  ```
  Creates: `release/retropad-1.0.1.zip` with SHA256 hash

- **`version.bat`** - Version configuration
  ```batch
  @set VERSION_MAJOR=1
  @set VERSION_MINOR=0
  @set VERSION_PATCH=0
  ```
  Edit before each release

- **`build-cmake.bat`** - Development build
  ```batch
  build-cmake.bat
  ```
  For daily development

### Templates
- **`release/release-notes-template.md`** - Release notes template
- **`.github/workflows/release.yml.template`** - GitHub Actions CI/CD

---

## 📦 Release Artifacts

### After Running `release-build.bat 1.0.0`
```
release/
├── retropad-1.0.0.zip                  (Distribution package)
│   └── retropad-1.0.0/
│       ├── retropad.exe                (Executable, 40 KB)
│       ├── README.md                   (Documentation)
│       └── RELEASE_NOTES.txt           (Auto-generated notes)
├── release-notes-template.md           (Template for custom notes)
└── retropad-1.0.0/                     (Unpacked release)
    ├── retropad.exe
    ├── README.md
    └── RELEASE_NOTES.txt
```

**Package stats:**
- ZIP size: ~21 KB
- Executable: ~40 KB
- Includes: README, auto-generated release notes
- SHA256: Auto-calculated for verification

---

## 🚀 Quick Start Workflows

### Create a Release (5 minutes)
```batch
REM 1. Update version
edit version.bat              # Set VERSION_MAJOR=1, VERSION_MINOR=0, VERSION_PATCH=1

REM 2. Update changelog
edit CHANGELOG.md             # Add new section for v1.0.1

REM 3. Build release
release-build.bat 1.0.1       # Creates release/retropad-1.0.1.zip

REM 4. Test
cd release\retropad-1.0.1
retropad.exe

REM 5. Git tag
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1

REM 6. GitHub Release (web UI)
REM    - Go to Releases
REM    - Create new release for v1.0.1
REM    - Attach release/retropad-1.0.1.zip
REM    - Publish
```

### Test Release Package
```batch
mkdir test-release
cd test-release
powershell -Command "Expand-Archive '../release/retropad-1.0.1.zip' ."
cd retropad-1.0.1
retropad.exe
REM Verify everything works
```

### Update Version (Development)
```batch
REM Edit these files:
version.bat                   # Set VERSION_MAJOR=1, VERSION_MINOR=0, VERSION_PATCH=2
CHANGELOG.md                  # Add "## [Unreleased]" section with changes
CMakeLists.txt               # Update project VERSION if needed
retropad.rc                  # Update FILEVERSION and PRODUCTVERSION if needed
```

### Continuous Integration Setup
```batch
REM Copy GitHub Actions template
copy .github\workflows\release.yml.template .github\workflows\release.yml

REM Commit
git add .github/workflows/release.yml
git commit -m "CI: Add GitHub Actions release automation"
git push

REM Now: git tag v1.0.0 and push tag → automatic GitHub release!
```

---

## 📋 Release Checklist

### Pre-Release
- [ ] All features complete and tested
- [ ] All bugs fixed
- [ ] No compiler warnings
- [ ] Code reviewed
- [ ] Unit tests pass (if applicable)

### Prepare Release
- [ ] Edit `version.bat` with new version
- [ ] Update `CHANGELOG.md` with changes
- [ ] Verify version consistency across files
- [ ] Create release notes (in `release/` directory if needed)

### Build & Package
- [ ] Run `release-build.bat X.Y.Z`
- [ ] Build succeeds with no errors
- [ ] ZIP file created
- [ ] SHA256 hash generated

### Test Release
- [ ] Extract ZIP to test directory
- [ ] Run `retropad.exe`
- [ ] Test all major features
- [ ] Verify no errors or crashes
- [ ] Confirm all files present

### Release
- [ ] Git commit with "Release: retropad vX.Y.Z"
- [ ] Create Git tag: `git tag -a vX.Y.Z -m "Release X.Y.Z"`
- [ ] Push tag: `git push origin vX.Y.Z`
- [ ] Create GitHub Release
- [ ] Attach `release/retropad-X.Y.Z.zip`
- [ ] Include release notes from `CHANGELOG.md`
- [ ] Publish release

### Post-Release
- [ ] Verify GitHub release is accessible
- [ ] Test download from GitHub
- [ ] Monitor for bug reports
- [ ] Respond to user feedback
- [ ] Plan next version

---

## 🔒 Security & Verification

### SHA256 Hash Verification
After building a release, hash is shown:
```
SHA256: ba66a629a718e84b3fdb7f0c3df985fcfc4df33296dd6ab32afe124d9dc56667
```

Users can verify:
```batch
certutil -hashfile retropad-1.0.1.zip SHA256
```

### Signing (Optional)
For enterprise deployment, sign the executable:
```batch
signtool sign /f certificate.pfx /p password retropad.exe
```

Requires: Paid code signing certificate (~$100-300/year)

---

## 📊 Version History

### v1.0.0 (Current)
**Released:** December 7, 2025
- Initial public release with all features
- Win32 Notepad-style interface
- Find/Replace, encoding support, settings persistence
- Clean build, zero compiler warnings
- Complete release management system

### Unreleased Changes
See [CHANGELOG.md](CHANGELOG.md) for pending features

---

## 🎯 File Navigation Quick Links

| Need | File |
|------|------|
| Quick start | [RELEASE_SETUP.md](RELEASE_SETUP.md) |
| Step-by-step release | [RELEASE_PROCESS.md](RELEASE_PROCESS.md) |
| System architecture | [RELEASE_MANAGEMENT.md](RELEASE_MANAGEMENT.md) |
| Deployment help | [DEPLOYMENT.md](DEPLOYMENT.md) |
| Version history | [CHANGELOG.md](CHANGELOG.md) |
| Build script | `release-build.bat` |
| Version config | `version.bat` |
| GitHub Actions | `.github/workflows/release.yml.template` |

---

## 💡 Common Questions

### Q: How do I build a release?
**A:** Run `release-build.bat 1.0.1` (one command, handles everything)

### Q: Where does it put the files?
**A:** `release/retropad-1.0.1/` and `release/retropad-1.0.1.zip`

### Q: How do I publish to GitHub?
**A:** See [DEPLOYMENT.md](DEPLOYMENT.md) section "GitHub Release"

### Q: Can it update automatically?
**A:** Yes, GitHub Actions workflow included (see `.github/workflows/release.yml.template`)

### Q: How do I verify the package integrity?
**A:** Compare SHA256 hash shown during build with user's verification

### Q: What's included in the package?
**A:** retropad.exe, README.md, RELEASE_NOTES.txt (auto-generated)

### Q: How do I add more files to release?
**A:** Edit `release-build.bat` "Step 5: Copy support files" section

### Q: Can I deploy to Microsoft Store?
**A:** Yes, future enhancement possible (requires MSIX packaging)

---

## 📞 Support Resources

- **Build Issues:** Check RELEASE_MANAGEMENT.md troubleshooting
- **Deployment Questions:** See DEPLOYMENT.md
- **Release Procedure:** Follow RELEASE_PROCESS.md
- **System Overview:** Review RELEASE_MANAGEMENT.md

---

## 🔄 Release System Status

✅ **Complete and Ready**

- ✅ Automated build scripting
- ✅ Version management
- ✅ Comprehensive documentation (4 guides + this index)
- ✅ SHA256 security verification
- ✅ GitHub integration ready
- ✅ CI/CD capability (GitHub Actions template)
- ✅ Distribution ready (ZIP packaging, notes generation)
- ✅ Example release tested (v1.0.0)

**Total Documentation:** 1,500+ lines across 5 files + this index

**Ready for:** Production releases, enterprise deployment, continuous integration

---

**Last Updated:** December 7, 2025  
**System Version:** 1.0.0  
**Release Script:** v1.0 (stable)
