@echo off
title DNS Switcher
cls
echo ==================================
echo       DNS SWITCHER SCRIPT
echo ==================================
echo 1. Set DNS to 78.157.42.101
echo 2. Remove DNS (Set to Automatic)
echo 3. Exit
echo ==================================
choice /c 123 /n /m "Choose an option (1-3): "

if %errorlevel%==1 goto SetDNS
if %errorlevel%==2 goto RemoveDNS
if %errorlevel%==3 exit

:SetDNS
echo Setting DNS to 78.157.42.101...
netsh interface ip set dns name="Wi-Fi" static 78.157.42.101
echo DNS has been set successfully!
pause
exit

:RemoveDNS
echo Removing DNS settings (Setting to Automatic)...
netsh interface ip set dns name="Wi-Fi" dhcp
echo DNS is now automatic!
pause
exit
