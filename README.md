# AdiosBot

Adios, inactive memberspo

![5871-adios-card-chihuahua](https://github.com/user-attachments/assets/a2630b75-7b36-41ed-9ed6-b16e44467fbc)


## Usage
```
source .envrc
export DISCORD_BOT_TOKEN="token"
python3 main.py
```

When running for the first time, the bot will download the last 10000 messages from every channel.

On subsequent runs, only new messages will be downloaded.

The bot only stores timestamps of the last message written by every member in the server.

## Commands
* `!inactive n` – Show users who haven't posted any messages in the past n days
* `!kick_inactive n` – Kick users who haven't posted any messages in the past n days
* `!whitelist add name` – Add user `name` to the whitelist (will not get kicked even if inactive)
* `!whitelist remove name` – Remove user `name` from the whitelist
* `!whitelist show` – Show the current whitelist
