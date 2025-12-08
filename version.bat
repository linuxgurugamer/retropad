@REM Version information - update these for each release
@REM Usage: Include this file in other batch scripts to get version info

@setlocal
@set VERSION_MAJOR=1
@set VERSION_MINOR=1
@set VERSION_PATCH=0
@set VERSION_BUILD=0

@set VERSION=%VERSION_MAJOR%.%VERSION_MINOR%.%VERSION_PATCH%
@set VERSION_FULL=%VERSION%.%VERSION_BUILD%

@REM Product info
@set PRODUCT_NAME=retropad
@set PRODUCT_DESC=A Petzold-style Win32 Notepad clone
@set COMPANY_NAME=retropad Contributors
@set FILE_DESC=%PRODUCT_DESC% (v%VERSION%)

@REM Dates
@for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (@set YEAR=%%c)
@set COPYRIGHT=Copyright (C) %YEAR% %COMPANY_NAME%

@endlocal
