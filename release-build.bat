@echo off
REM Release build and packaging script for retropad
REM Usage: release-build.bat [version]
REM Example: release-build.bat 1.0.0

setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: release-build.bat [version]
    echo Example: release-build.bat 1.0.0
    exit /b 1
)

set VERSION=%1
set RELEASE_DIR=release\retropad-%VERSION%
set OUTPUT_ZIP=release\retropad-%VERSION%.zip

echo.
echo ========================================
echo retropad Release Build v%VERSION%
echo ========================================
echo.

REM Step 1: Clean previous builds
echo Step 1: Cleaning previous builds...
if exist build (
    echo  - Removing build directory...
    rmdir /s /q build
)
if exist %RELEASE_DIR% (
    echo  - Removing previous release directory...
    rmdir /s /q %RELEASE_DIR%
)
if exist %OUTPUT_ZIP% (
    echo  - Removing previous ZIP...
    del %OUTPUT_ZIP%
)

REM Step 2: Build with CMake (Release configuration)
echo.
echo Step 2: Building Release configuration...
call build-cmake.bat
if errorlevel 1 (
    echo ERROR: Build failed!
    exit /b 1
)

REM Step 3: Create release directory structure
echo.
echo Step 3: Creating release package...
mkdir %RELEASE_DIR%

REM Step 4: Copy executable
echo  - Copying retropad.exe...
copy build\bin\Release\retropad.exe %RELEASE_DIR%\

REM Step 5: Copy support files
echo  - Copying README from template...
REM Replace version number and current date in template
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (set mydate=%%c/%%a/%%b)
powershell -NoProfile -Command "((Get-Content 'release\release-notes-template.md') -replace '1\.0\.5', '%VERSION%' -replace '\[DATE\]', '%date%') | Out-File '%RELEASE_DIR%\README.md' -Encoding UTF8"

echo  - Copying LICENSE (if exists)...
if exist LICENSE (
    copy LICENSE %RELEASE_DIR%\
)

REM Step 6: Create release notes (deprecated, template is now README)
echo  - Release notes integrated into README.md

REM Step 7: Create ZIP archive
echo  - Creating ZIP archive...
powershell -NoProfile -Command "Compress-Archive -Path '%RELEASE_DIR%' -DestinationPath '%OUTPUT_ZIP%' -Force"

if errorlevel 1 (
    echo ERROR: Failed to create ZIP!
    exit /b 1
)

REM Step 8: Calculate file size and hash
echo.
echo Step 4: Release package complete!
echo.
echo Package Details:
echo  - Location: %OUTPUT_ZIP%
for %%A in (%OUTPUT_ZIP%) do echo  - Size: %%~zA bytes
echo  - Executable: %RELEASE_DIR%\retropad.exe

REM Calculate SHA256 (if certutil available)
if exist %OUTPUT_ZIP% (
    echo.
    echo SHA256 Hash:
    certutil -hashfile %OUTPUT_ZIP% SHA256 | find /v ":" | find /v "CertUtil"
)

echo.
echo ========================================
echo Release build v%VERSION% complete!
echo ========================================
echo.
