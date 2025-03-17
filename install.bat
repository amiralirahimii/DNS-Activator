@echo off
setlocal enabledelayedexpansion

:: Enable ANSI escape sequences (for Windows 10+)
for /F "delims=" %%A in ('echo prompt $E^| cmd') do set "ESC=%%A"
set "RED=%ESC%[91m"
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "BLUE=%ESC%[94m"
set "MAGENTA=%ESC%[95m"
set "CYAN=%ESC%[96m"
set "RESET=%ESC%[0m"

:: [Step 1] Check for administrator privileges
echo %BLUE%[Step 1/4] Checking administrator privileges...%RESET%
NET FILE >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo %YELLOW%Requesting administrator privileges...%RESET%
    timeout /t 1 >nul
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
:: Display header
echo %CYAN%==================================================%RESET%
echo %CYAN%               DNS SWITCHER INSTALLER           %RESET%
echo %CYAN%==================================================%RESET%
echo.

:: [Step 2] Set paths and display installation info
set "TARGET=%~dp0dns_switcher.bat"
set "LNK=%USERPROFILE%\Desktop\DNS Switcher.lnk"

echo %BLUE%[Step 2/4] Preparing installation...%RESET%
echo %MAGENTA%Source File:%RESET% %TARGET%
echo %MAGENTA%Shortcut:%RESET% %LNK%
echo.
choice /C YN /M "Proceed with installation (Y/N)? "
if errorlevel 2 goto cancel

:: Verify that the main script exists
if not exist "%TARGET%" (
    echo %RED%Error: Could not find dns_switcher.bat!%RESET%
    echo %YELLOW%Ensure the installer is in the same folder as dns_switcher.bat%RESET%
    pause
    exit /b 1
)

:: [Step 3] Create the desktop shortcut
echo %BLUE%[Step 3/4] Creating desktop shortcut...%RESET%
powershell -Command "$s=New-Object -COM WScript.Shell; $sc=$s.CreateShortcut('%LNK%'); $sc.TargetPath='cmd.exe'; $sc.Arguments='/c \"\"%TARGET%\"\"'; $sc.WorkingDirectory='%~dp0'; $sc.IconLocation='%SystemRoot%\System32\shell32.dll,15'; $sc.Save()"

if not exist "%LNK%" (
    echo %RED%Failed to create shortcut!%RESET%
    pause
    exit /b 1
)

:: [Step 4] Set admin flag on the shortcut
echo %BLUE%[Step 4/4] Setting admin privileges on shortcut...%RESET%
powershell -Command "$bytes=[IO.File]::ReadAllBytes('%LNK%'); $bytes[21]=32; [IO.File]::WriteAllBytes('%LNK%', $bytes)"

echo.
echo %GREEN%Installation complete!%RESET%
echo %GREEN%Shortcut created on your desktop.%RESET%
pause
exit /b 0

:cancel
echo %YELLOW%Installation cancelled by user.%RESET%
timeout /t 2 /nobreak >nul
exit /b 0
