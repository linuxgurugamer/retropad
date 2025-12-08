# retropad Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Current Release [1.1.0]

### Added
- **Dark Mode Support** (v1.0.2-1.1.0):
  - Toggle dark mode theme in Settings dialog (`IDC_SETTINGS_DARKMODE` checkbox)
  - Dark mode colors:
    - Editor background: RGB(30, 30, 30) - dark gray
    - Text color: RGB(230, 230, 230) - light gray
  - Dark window frame and borders (Windows 10+ via DwmSetWindowAttribute API)
  - Dark status bar with theme-aware colors
  - Automatic brush creation and management for performance
  - Proper cleanup of theme resources in WM_DESTROY
  - Settings persist across sessions via Registry
  - Eye strain reduction in low-light environments
  
- **WM_CTLCOLEREDIT Message Handler**:
  - Handles edit control coloring for both light and dark modes
  - Dynamic brush creation (g_darkBkBrush, g_lightBkBrush)
  - Color values: `#define WM_CTLCOLOREDIT 0x0019` (constant added)

- **WM_CTLCOLORSTATIC Message Handler**:
  - Status bar coloring support
  - Separate brush management (g_darkStatusBrush, g_lightStatusBrush)
  - Light mode fallback (RGB 240, 240, 240 background)

- **WM_ERASEBKGND Message Handler**:
  - Main window background painting in dark mode
  - Prevents white background flash when dark mode enabled

- **Windows 10+ Dark Mode API Support**:
  - Dynamic loading of `dwmapi.dll` (DwmSetWindowAttribute function)
  - `DWMWA_USE_IMMERSIVE_DARK_MODE` (0x0014) attribute support
  - Graceful fallback for older Windows versions

- **MIT License**:
  - Created LICENSE file with MIT license text
  - Copyright: (c) 2025 Alt3rnativity
  - Updated system information in README template

- **Enhanced Release Build System** (v1.1.0):
  - Release template-based README generation
  - Automatic version number replacement in generated README
  - Automatic release date insertion (`[DATE]` placeholder)
  - Dynamic System Information section updates
  - LICENSE file automatically included in release ZIP
  - PowerShell-based template processing for robust replacements

### Fixed
- **Build Error C2065**: `WM_CTLCOLEREDIT` undeclared identifier
  - Added `#define WM_CTLCOLOREDIT 0x0019` constant
  - Resolved case expression not constant error (C2051)

- **Dark Mode Toggle Issues**:
  - Recreate edit control when toggling dark mode (forces re-rendering)
  - Proper brush deletion and re-initialization
  - Full window repaint including status bar (InvalidateRect + UpdateWindow)
  - Clean separation of dark/light mode resources

### Changed
- **Release Build Script** (`release-build.bat`):
  - Replaced hardcoded release notes generation with template-based approach
  - Added dynamic version and date replacement
  - Changed README generation from inline script to template file (`release\release-notes-template.md`)
  - Template preserves user guide content across releases
  - Automatic placeholder replacement: `1.1.0` → version number, `[DATE]` → current date

- **README Template Structure**:
  - Comprehensive user guide with sections:
    - Getting Started (Installation, Requirements)
    - Basic Usage (File operations, Editing, Finding/Replacing)
    - Settings & Customization (Display, File settings, Dark Mode)
    - Advanced Features (Status Bar, Encoding detection)
    - Tips & Tricks (Productivity, Performance)
    - Keyboard Shortcuts Reference (table format)
    - Troubleshooting (Common Issues, Getting Help)
    - System Information (Version, Date, Build info, License)

- **Global Application State**:
  - Added `BOOL darkModeEnabled` field to `AppState` structure
  - Settings now persist dark mode preference via Registry

### Improved
- **Code Organization**:
  - Better message handler organization (WM_* cases in order)
  - Resource cleanup in WM_DESTROY (brushes, etc.)
  - Forward declarations for new functions

- **User Experience**:
  - Seamless dark mode toggle in Settings
  - Theme applies immediately with window repaint
  - Persistent theme preference across sessions
  - Professional release packages with comprehensive documentation

- **Release Management**:
  - Automated release documentation generation
  - Consistent version information across all release artifacts
  - Reduced manual steps in release process
  - Better maintainability of release templates

### Known Limitations
- Menu bar (File/Edit/Format/View/Help) remains light in dark mode
  - Windows limitation: non-client area controlled by OS
  - Owner-drawn menu implementation attempted but reverted (too complex)
  - Not a critical issue as menus remain functional

- Dark mode requires Windows 10+ for full frame/border theming
  - Older Windows (7, 8.1) still get dark editor and status bar
  - DwmSetWindowAttribute gracefully fails on unsupported versions

## [1.0.0] - 2025-01-15

### Added
- Initial public release
- Win32 Notepad-style interface
- File operations (New, Open, Save)
- Edit operations (Cut, Copy, Paste, Undo, Delete, Select All)
- Find & Replace with bidirectional search
- Go To Line dialog
- Font picker with customizable font and size
- Insert Time/Date functionality
- Word wrap toggle
- Status bar (shows line, column, total lines)
- Multiple encoding support:
  - UTF-8 with BOM detection
  - UTF-16 LE/BE with BOM detection
  - ANSI fallback
- Keyboard accelerators for common operations
- Drag-and-drop file support
- Registry-based settings (word wrap, status bar, encoding)
- CMake build system
- MSVC build support
- MinGW/GCC build support (optional Makefile)

### Architecture
- Modular design: UI logic, file I/O, and resources separated
- Global application state structure (`AppState`)
- Message-based UI (WM_* message handler pattern)
- Registry persistence for user preferences

### Known Limitations
- No syntax highlighting
- No multi-tab interface
- No advanced formatting (bold, italics, etc.)
- No print support (intentionally omitted)
- No undo/redo beyond single level

---

## Release Workflow

### Preparing a Release

1. **Update version numbers:**
   - `CMakeLists.txt`: Update `VERSION` and `project()` version
   - `resource.h`: Update version constants if needed
   - `retropad.rc`: Update version info strings

2. **Update documentation:**
   - Add entry to `CHANGELOG.md` with new version and date
   - Update `README.md` if needed
   - Create release notes in `release/release-notes-X.Y.Z.md`

3. **Build release package:**
   ```batch
  release-build.bat 1.1.0
   ```
   This script:
   - Cleans previous builds
   - Builds Release configuration with optimization
   - Creates release directory structure
   - Packages as ZIP archive
   - Generates SHA256 hash

4. **Test the release package:**
   - Extract ZIP on clean test machine
   - Verify executable runs correctly
   - Test all major features
   - Verify no missing dependencies

5. **Tag release in Git:**
   ```batch
  git tag -a v1.1.0 -m "Release version 1.1.0"
  git push origin v1.1.0
   ```

6. **Upload to GitHub:**
   - Create GitHub Release
   - Attach ZIP package
   - Include release notes and changelog excerpt

### Version Strategy

- **Major (X.0.0):** Breaking changes, major features
- **Minor (0.Y.0):** New features, non-breaking changes
- **Patch (0.0.Z):** Bug fixes, documentation updates
