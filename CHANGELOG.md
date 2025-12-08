# retropad Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Settings dialog with word wrap, status bar, and autosave options
- Registry-based settings persistence
- Autosave feature with configurable intervals (5-3600 seconds)
- Refactored codebase with improved modularity:
  - Extracted registry helper functions (`RegReadDword`, `RegWriteDword`)
  - Extracted search buffer preparation helper (`PrepareSearchBuffers`)
  - Extracted Find/Replace initialization helper (`InitializeFindReplace`)
  - Extracted autosave settings management (`ApplyAutosaveSettings`)
  - Added `AppMessageBox` macro for consistency

### Fixed
- RC accelerator syntax (now uses hex VK codes with VIRTKEY flag)
- Compiler warnings (C4100, C4203, C4244)
- Edge case handling in `DetectEncoding()` for empty files

### Changed
- Find/Replace dialog initialization now consolidated in single function
- Settings dialog now uses extracted helper for autosave management
- Registry operations now use consistent helper functions

### Improved
- Code maintainability through refactoring (~80 lines reduction, 8-10%)
- Error handling consistency in registry operations
- Documentation with inline comments and accelerator table reference

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
   release-build.bat 1.0.1
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
   git tag -a v1.0.1 -m "Release version 1.0.1"
   git push origin v1.0.1
   ```

6. **Upload to GitHub:**
   - Create GitHub Release
   - Attach ZIP package
   - Include release notes and changelog excerpt

### Version Strategy

- **Major (X.0.0):** Breaking changes, major features
- **Minor (0.Y.0):** New features, non-breaking changes
- **Patch (0.0.Z):** Bug fixes, documentation updates
