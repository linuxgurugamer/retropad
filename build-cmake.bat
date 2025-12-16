@echo off
REM CMake build script for retropad with Visual Studio 2022

setlocal enabledelayedexpansion

REM Check if cmake is installed
where cmake >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: CMake is not found in PATH
    echo Please install CMake from https://cmake.org/download/
    exit /b 1
)

REM Kill any running retropad instance
taskkill /F /IM retropad.exe >nul 2>nul

REM Wait a moment for the process to close
timeout /t 1 /nobreak >nul 2>nul

REM Create build directory
if not exist "build" mkdir build
cd build

REM Configure with MSVC (Visual Studio 17 2022, x64)
echo Configuring CMake...
cmake .. -G "Visual Studio 17 2022" -A x64

if %ERRORLEVEL% NEQ 0 (
    echo Configuration failed!
    cd ..
    exit /b 1
)

REM Build Release configuration
echo.
echo Building Release configuration...
cmake --build . --config Release

if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    cd ..
    exit /b 1
)

echo.
echo Build successful! Output: %CD%\bin\Release\retropad.exe
cd ..

REM Run the application
if exist "build\bin\Release\retropad.exe" (
    echo.
    echo Starting retropad...
    start build\bin\Release\retropad.exe
)
