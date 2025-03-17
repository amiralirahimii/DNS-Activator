@echo off
title DNS Switcher
cls
echo ==================================
echo       DNS SWITCHER SCRIPT
echo ==================================
echo 1. Set DNS to 178.22.122.100        (Shecan)
echo 2. Set DNS to 78.157.42.101         (Electro)
echo 3. Remove DNS (Set to Automatic)
echo 4. Exit
echo ==================================
choice /c 1234 /n /m "Choose an option (1-4): "

if %errorlevel%==1 goto SetDNS_Shecan
if %errorlevel%==2 goto SetDNS_Electro
if %errorlevel%==3 goto RemoveDNS
if %errorlevel%==4 exit

:SetDNS_Shecan
echo Setting DNS to 178.22.122.100 (Shecan)...
netsh interface ip set dns name="Wi-Fi" static 178.22.122.100
echo DNS has been set successfully!
pause
exit

:SetDNS_Electro
echo Setting DNS to 78.157.42.101 (Electro)...
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
