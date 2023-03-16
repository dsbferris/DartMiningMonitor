# Flexpool Mining Monitor Telegram Bot in Dart [FlexMiMonBotDart or just ]

## First things first!
Check `@` on telegram. I only recommend using my bot for testing.
Better create your own bot using `@BotFather`. Also keep in mind if you use my bot,
I got your wallet and Telegram profile. Not that I'm not trustworthy, but better you know.
Also please note that I'm not encrypting any of the saved data.

### How to use
Start by messaging bot with <code>/start 0xYOURWALLETHERE1234"</code>  
Then select time for daily news.  
Note: YOU CANNOT CHANGE THAT TIME LATER!
([checkout why](#why-there-is-currently-no-way-to-change-the-time))
- now
- e.g. 10:00 (only EU format, no AM/PM)
- never

Selecting never will disable daily report and choose now for retrieving data. You will then only be notified when a Payout happens.
Note: by selecting a custom time, the bot will wait the first time for that given time with retrieving any data!

### How to use (advanced)
Additional commands:
- <code>/help</code> displays help and links to here, who could have expected this
- <code>/daily on/off</code> to switch daily notification on or off.
- <code>/silent on/off</code> to switch whether all bot notification will cause a sound (default: off)
- <code>@ eth-eur</code> to send current counter-value into ANY chat. (If eth-usd is needed, create an Issue here[INSERT LINK])
- <code>/stop</code> will stop this bot. It will one last time print out current shares per worker for the ongoing Payout.
Then all data is about your Telegram profile and your workers and payouts is getting deleting from database, except for last two when someone else subscribed to that address as well.

#### Planned features upcoming versions
- <code>/alarm price (e.g. 3000€)</code> sends un-mutable notification when price hits target
- Small menu to manage these alarms, like showing and deleting them.
- Should an alarm be deleted after it triggered?
- How often should the price be retrieved by an API?

#### Why there is (currently) no way to change the time
Changing the time would mess up the 24h retrieval of share data. ([checkout why](#why-request-api-every-24h))  
I mean, I could allow it, but you should preferably use it right after a payout happens.
I could also keep the retrieving time the same and only let you change the notification time, 
but this would make me do coding another routine and scheduling for it, instead of having all stuff done easily at once.


### How to build
// TODO docker build ...  
// TODO docker run ... (with environment variable for telegram bot token)


### API Calls that are being used
- /worker/stats
- /worker/payments
- ...
- //TODO ADD MORE

### Why request API every 24h?
Because Flexpool saves your worker's shares for 24h,
so retrieving this every 24h should give a kinda precise, but not 100% accurate, values.

## Notes
Hive Type Numbers

| Number | Class       |
|--------|-------------|
| ~~0~~      | ~~Worker~~      |
| 1      | ChatEntry   |
| 2      | WalletEntry |

Hive saves key-value pairs in named boxes
Let's say to use one box for saving chats and their subscribed addresses  
**CHATS**:  
Chat-ID paired with Address, daily report time and an optional nickname for this wallet.

| Chat ID | List of Class WalletTimeNickname                                                             |
|---------|----------------------------------------------------------------------------------------------|
| 12345   | [["0x000", "10 00"], ["0x111", "06 30", "Bro"], ["0x222", "12 00", ""]]          |
| 98745   | [["0x999", "16 45", "Yours"], ["0x888", "09 00", "RichKid"], ["0x777", "10 15", "LuckyGuy"]] |
| .....   | ........                                                                                     |

