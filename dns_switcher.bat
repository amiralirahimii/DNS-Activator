@echo off
setlocal EnableDelayedExpansion
set "vbar=|"
title DNS Switcher
color 1F

:Main
cls
echo +---------+-------------------------------------------+
echo !vbar! Option  !vbar! DNS Configuration                         !vbar!
echo +---------+-------------------------------------------+
echo !vbar! 1       !vbar! 178.22.122.100 (Shecan)                   !vbar!
echo !vbar! 2       !vbar! 78.157.42.101 (Electro)                   !vbar!
echo !vbar! 3       !vbar! Automatic (DHCP)                          !vbar!
echo !vbar! 4       !vbar! Exit                                      !vbar!
echo +---------+-------------------------------------------+
echo.
set /p choice="Select an option (1-4): "

if "%choice%"=="1" goto SetShecan
if "%choice%"=="2" goto SetElectro
if "%choice%"=="3" goto SetAutomatic
if "%choice%"=="4" goto Exit

echo Invalid option. Exiting.
pause
goto Exit

:SetShecan
cls
echo +-------------------------------------------+
echo !vbar! Configuring DNS for Shecan                !vbar!
echo +-------------------------------------------+
netsh interface ip set dns name="Wi-Fi" static 178.22.122.100
echo.
echo +-------------------------------------------+
echo !vbar! DNS successfully set to:               !vbar!
echo !vbar! 178.22.122.100 (Shecan)                   !vbar!
echo +-------------------------------------------+
echo.
echo Press any key to exit...
pause >nul
exit

:SetElectro
cls
echo +-------------------------------------------+
echo !vbar! Configuring DNS for Electro               !vbar!
echo +-------------------------------------------+
netsh interface ip set dns name="Wi-Fi" static 78.157.42.101
echo.
echo +-------------------------------------------+
echo !vbar! DNS successfully set to:               !vbar!
echo !vbar! 78.157.42.101 (Electro)                   !vbar!
echo +-------------------------------------------+
echo.
echo Press any key to exit...
pause >nul
exit

:SetAutomatic
cls
echo +-------------------------------------------+
echo !vbar! Reverting DNS to Automatic (DHCP)         !vbar!
echo +-------------------------------------------+
netsh interface ip set dns name="Wi-Fi" dhcp
echo.
echo +-------------------------------------------+
echo !vbar! DNS configuration reset to automatic!   !vbar!
echo +-------------------------------------------+
echo.
echo Press any key to exit...
pause >nul
exit

:Exit
exit
