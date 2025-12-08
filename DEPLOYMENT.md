# retropad Distribution & Deployment Guide

## Distribution Channels

### 1. GitHub Releases (Primary)
- **URL:** https://github.com/PlummersSoftwareLLC/retropad/releases
- **Format:** ZIP package with executable
- **Best for:** Developers, public distribution
- **Process:**
  1. Run `release-build.bat X.Y.Z`
  2. Create GitHub Release
  3. Attach ZIP file
  4. Include release notes

### 2. Direct Download (Website)
- Host ZIP files on project website
- Provide direct download links
- Include SHA256 hashes for verification
- Keep multiple versions available

### 3. Microsoft Store (Optional Future)
- Submit app to Microsoft Store
- Automatic updates via Store
- Requires MSIX packaging
- Recommended for end-user distribution

### 4. Chocolatey (Optional)
- Windows package manager
- Easy installation: `choco install retropad`
- Community-maintained
- Package definition: `retropad.nuspec`

## System Requirements

### Minimum
- **OS:** Windows 7 SP1 or later
- **Runtime:** Visual Studio 2022 Runtime (msvcrt)
- **Disk:** ~50 MB free space

### Recommended
- **OS:** Windows 10 or Windows 11
- **RAM:** 512 MB (typical)
- **Features:** .NET Framework (optional, not required for retropad)

## Installation Methods

### Method 1: Portable Executable (Recommended)
```
1. Download retropad-X.Y.Z.zip
2. Extract to desired location
3. Run retropad.exe
```

**Advantages:**
- No installation required
- No registry changes (except settings)
- Can run from USB drive
- Easy to uninstall (delete folder)

**File locations:**
- Registry: `HKEY_CURRENT_USER\Software\retropad`
- No other system modifications

### Method 2: Start Menu Shortcut
Create Windows shortcut to retropad.exe:

```batch
REM Create shortcut
powershell -Command "$ws = New-Object -ComObject WScript.Shell; $shortcut = $ws.CreateShortCut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\retropad.lnk'); $shortcut.TargetPath = 'C:\Path\To\retropad.exe'; $shortcut.Save()"
```

Or manually:
1. Right-click desktop → New → Shortcut
2. Target: `C:\Path\To\retropad.exe`
3. Name: `retropad`
4. Move to Start Menu if desired

### Method 3: Command Line
Add retropad directory to PATH:

```batch
REM Add to system PATH (requires admin)
setx PATH "%PATH%;C:\Path\To\retropad"
```

Then run: `retropad.exe` from any command prompt

## Deployment Checklist

### Pre-Deployment
- [ ] All tests pass on target Windows versions
- [ ] Release notes complete and accurate
- [ ] SHA256 hash documented
- [ ] ZIP package verified to extract correctly
- [ ] File permissions set appropriately

### Deployment
- [ ] Upload ZIP to distribution channel (GitHub, website, etc.)
- [ ] Verify download works
- [ ] Test executable on clean system
- [ ] Confirm all features functional
- [ ] Check for runtime errors

### Post-Deployment
- [ ] Monitor for bug reports
- [ ] Respond to support requests
- [ ] Document known issues
- [ ] Plan next version/fixes

## Dependencies & Runtime

### Included in Windows 10+
- User32.dll (windowing)
- GDI32.dll (graphics)
- Shell32.dll (shell integration)
- Comdlg32.dll (file dialogs)
- Comctl32.dll (common controls)

### May Require Installation (Windows 7)
- **Visual C++ Runtime:** `vcredist_x64.exe` or `vcredist_x86.exe`
- Download from Microsoft: https://support.microsoft.com/en-us/help/2977003

### Not Required
- .NET Framework (retropad is native C)
- Python, Node.js, Java, etc.
- Development tools

## Deployment for Different Environments

### Enterprise/Corporate
```
1. Build release
2. Sign executable (optional but recommended for security)
3. Place on network share
4. Distribute via Group Policy or MDT
5. Update centrally
```

### Small Team/Personal
```
1. Build release
2. Upload to GitHub/Google Drive
3. Share link with users
4. Users extract and run
```

### End Users (General Public)
```
1. Build release
2. Upload to website with download page
3. Include installation instructions
4. Provide support contact
5. Document system requirements
```

## Signing the Executable (Optional Security)

For increased trust, digitally sign retropad.exe:

```batch
REM Requires code signing certificate
signtool sign /f certificate.pfx /p password /t http://timestamp.server retropad.exe
```

**Benefits:**
- Reduces SmartScreen warnings
- Proves publisher authenticity
- Users can verify integrity

**Cost:** Commercial code signing certificates (~$100-300/year)

## Troubleshooting Distribution Issues

### Users report "Missing DLL"
**Solution:** Provide Visual C++ Runtime redistributable
```batch
REM Direct users to download and install:
vcredist_x64.exe
```

Or include in package:
```
retropad-1.0.1/
├── retropad.exe
├── vcredist_x64.exe          (optional)
├── README.md
└── INSTALL.txt
```

### Users report SmartScreen warning
This is normal for unsigned/new software:
1. Click "More info"
2. Click "Run anyway"

To eliminate: Sign the executable (paid certificate required)

### Antivirus false positive
- Submit executable to antivirus vendors for analysis
- Usually resolves within 24-48 hours
- Communicate timeline to users

### Corrupted download
**Solution:** Verify SHA256 hash
```batch
certutil -hashfile retropad.exe SHA256
```
Compare to documented hash. If different, re-download.

## Update Strategy

### Automatic Update Check (Future Feature)
Could implement in-app update checking:
1. Query GitHub API for latest release
2. Compare versions
3. Prompt user to update
4. Download and verify hash
5. Replace executable

Example check (pseudo-code):
```c
// Query https://api.github.com/repos/PlummersSoftwareLLC/retropad/releases/latest
// Extract version and download_url
// Compare with local version
// If newer, prompt user for update
```

### Manual Update
Users manually download new version and replace retropad.exe

## Version Lifecycle

### Active Support
- Latest version: Full support
- Previous version: Bug fixes only
- Older versions: No support

### Deprecation
- Announce in release notes
- Give 6-month notice
- Migrate users to newer version

### End of Life
- Stop publishing updates
- Archive releases
- Redirect users to latest

## Documentation for Distribution

### Include in Package
- **README.md** - Project overview, features, usage
- **LICENSE** - Licensing information
- **RELEASE_NOTES.txt** - This version's changes
- **CHANGELOG.md** - Full history (optional)

### Host Online
- Project website with download links
- Installation instructions
- FAQ and troubleshooting
- Feature documentation

## Performance & Scalability

### Single User
- Direct download
- No infrastructure needed
- Minimal bandwidth

### Team (10-100 users)
- Host on GitHub/DropBox/OneDrive
- Peer distribution possible
- Minimal costs

### Enterprise (100+ users)
- On-premises distribution server
- MDT/Group Policy deployment
- Centralized version control
- Automatic update capability

## Success Metrics

Track these post-deployment:
- [ ] Download counts
- [ ] Active user base
- [ ] Bug report frequency
- [ ] User satisfaction
- [ ] Version distribution (% on latest)
- [ ] Support request volume

---

## Quick Release Checklist

```
Before:
  [ ] Code complete & tested
  [ ] Documentation updated
  [ ] Version number decided

Build:
  [ ] release-build.bat succeeds
  [ ] ZIP created without errors
  [ ] SHA256 hash generated

Verify:
  [ ] Extract ZIP on test machine
  [ ] Run retropad.exe
  [ ] Test basic features
  [ ] Confirm no errors

Distribute:
  [ ] Upload to GitHub
  [ ] Create release entry
  [ ] Attach ZIP file
  [ ] Include release notes
  [ ] Publish release

Monitor:
  [ ] Track downloads
  [ ] Monitor for issues
  [ ] Respond to feedback
  [ ] Plan next release
```

---

**Last Updated:** December 7, 2025
