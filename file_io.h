// File loading and saving helpers for retropad
#pragma once

#include <windows.h>

typedef enum TextEncoding {
    ENC_UTF8 = 1,
    ENC_UTF16LE = 2,
    ENC_UTF16BE = 3,
    ENC_ANSI = 4
} TextEncoding;

BOOL OpenFileDialog(HWND owner, WCHAR *pathOut, DWORD pathLen);
BOOL SaveFileDialog(HWND owner, WCHAR *pathOut, DWORD pathLen);

BOOL LoadTextFile(HWND owner, LPCWSTR path, WCHAR **textOut, size_t *lengthOut, TextEncoding *encodingOut);
BOOL SaveTextFile(HWND owner, LPCWSTR path, LPCWSTR text, size_t length, TextEncoding encoding);

// Settings persistence (JSON file in AppData)
typedef struct AppSettings {
    BOOL wordWrap;
    BOOL statusVisible;
    BOOL autosaveEnabled;
    DWORD autosaveInterval;  // in seconds
    BOOL darkModeEnabled;
    BOOL modified;
    TextEncoding encoding;
} AppSettings;

BOOL LoadAppSettings(AppSettings *settings);
BOOL SaveAppSettings(const AppSettings *settings);
