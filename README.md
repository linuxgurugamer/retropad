# Retropad User Guide

Welcome to **retropad** - a lightweight, feature-rich text editor for Windows!

---

## Getting Started

### Installation
1. Download `retropad-1.0.5.zip`
2. Extract to your desired location (e.g., `C:\Program Files\retropad`)
3. Run `retropad.exe`
4. (Optional) Create a Windows Start Menu shortcut

**No installation required** - retropad is fully portable!

### System Requirements
- Windows 7 or later
- 5 MB disk space
- Display resolution: 800x600 minimum (1920x1080 recommended)

---

## Basic Usage

### Opening & Creating Files
- **New File**: `Ctrl+N` or File â†’ New
- **Open File**: `Ctrl+O` or File â†’ Open
- **Save File**: `Ctrl+S` or File â†’ Save
- **Save As**: `Ctrl+Shift+S` or File â†’ Save As
- **Recent Files**: File â†’ Recent Files (quick access)

### Editing

#### Text Selection & Navigation
- **Select All**: `Ctrl+A`
- **Copy**: `Ctrl+C`
- **Cut**: `Ctrl+X`
- **Paste**: `Ctrl+V`
- **Undo**: `Ctrl+Z`
- **Redo**: `Ctrl+Y`

#### Finding & Replacing
- **Find**: `Ctrl+F` - Search for text in your document
- **Replace**: `Ctrl+H` - Find and replace text
- **Find Next**: `F3` or press Enter in Find dialog
- **Case Sensitive**: Enable checkbox to match uppercase/lowercase exactly

#### Text Formatting
- **Word Wrap**: View â†’ Word Wrap (toggle on/off)
  - ON: Text wraps to window width automatically
  - OFF: Horizontal scrolling for long lines

---

## Settings & Customization

Access Settings via: **File â†’ Settings** (or press `Ctrl+Shift+,`)

### Display Settings

**Font Customization**
- Click "Select Font" to choose typeface, size, and style
- Changes apply immediately to current document
- Recommended: Consolas, Courier New, or Segoe UI Mono for coding

**Word Wrap**
- Toggle automatic line wrapping
- Enable for reading documents
- Disable for editing code with long lines

**Status Bar Visibility**
- Show/hide the bottom status bar
- Status bar displays: file path, cursor position, encoding, line/column count

**Dark Mode**
- Toggle dark mode theme on/off
- Dark mode features:
  - Dark text editor background (RGB 30, 30, 30)
  - Light gray text (RGB 230, 230, 230)
  - Dark window borders and frame (Windows 10+)
  - Dark status bar
  - Reduces eye strain in low-light environments
- Settings are saved automatically and applied on next startup
- Menu bar (File/Edit/etc.) remains light due to Windows limitations

### File Settings

**Text Encoding** (shown in status bar)
- Automatically detected on file open
- Auto-save includes current encoding
- Supported formats: UTF-8, UTF-16, ANSI (CP1252)

**Auto-save Interval**
- Enable automatic saving at regular intervals
- Set interval: 1-60 minutes
- Useful for preventing accidental data loss
- Files saved to original location

---

## Advanced Features

### Status Bar Information
Bottom of window shows:
- **File Path**: Full path to current document
- **Cursor Position**: Line and column numbers
- **Encoding**: Current file encoding (UTF-8, ANSI, etc.)
- **Line Count**: Total lines in document

### File Encoding Detection
retropad automatically detects:
- **UTF-8** (with or without BOM)
- **UTF-16** (LE/BE with BOM)
- **ANSI** (Windows-1252)

Falls back to ANSI if detection fails.

### Settings Persistence
Your preferences are saved automatically:
- Font selection & size
- Window size & position
- Word wrap preference
- Status bar visibility
- Auto-save settings

All settings stored securely in Windows Registry (per-user).

---

## Tips & Tricks

### Productivity
- Use `Ctrl+F` to quickly find recurring text
- `Ctrl+H` for bulk replacements across entire document
- `Ctrl+A` then select font to format all text at once
- Enable auto-save for important documents

### Performance
- For very large files (>100 MB), disable Word Wrap
- Close unused windows to free memory
- Auto-save intervals: 5-15 minutes recommended for active editing

### Keyboard Shortcuts Reference
| Action | Shortcut |
|--------|----------|
| New | `Ctrl+N` |
| Open | `Ctrl+O` |
| Save | `Ctrl+S` |
| Save As | `Ctrl+Shift+S` |
| Find | `Ctrl+F` |
| Replace | `Ctrl+H` |
| Find Next | `F3` |
| Settings | `Ctrl+Shift+,` |
| Select All | `Ctrl+A` |
| Copy | `Ctrl+C` |
| Cut | `Ctrl+X` |
| Paste | `Ctrl+V` |
| Undo | `Ctrl+Z` |
| Redo | `Ctrl+Y` |

---

## Troubleshooting

### Common Issues

**"File not found" error**
- Verify file path is correct
- Check file permissions (read-only?)
- Try opening with File â†’ Open dialog

**Encoding issues (garbled text)**
- Check encoding in status bar
- Try different encoding in Settings
- UTF-8 recommended for web content

**Auto-save not working**
- Ensure file location is writable
- Check auto-save is enabled in Settings
- Verify sufficient disk space available

**Settings not saving**
- Run retropad as Administrator
- Check Windows Registry permissions
- Restart application after Settings change

### Getting Help
- Check this User Guide
- Review Settings dialog tooltips
- Ensure Windows is up-to-date

---

## System Information

- **Version**: 1.0.5
- **Release Date**: Mon 12/08/2025
- **Built with**: Visual Studio 2022 MSVC v143
- **Platform**: Windows (32-bit/64-bit compatible)
- **License**: MIT License - See LICENSE file for details

---

**Enjoy retropad!** For feedback or bug reports, visit the official repository.
