# DavesTimerApp
Very simple cli timer application for i3blocks.

## Install
- Run install.sh
- Add this to ~/.config/i3blocks/config:

```config
[timer]
command=./scripts/DavesTimerApp/timer.sh
interval=1
min_width=200
```
Done!

## Usage
Use `addt` command to run the app.
You will see this:
```
-------------------------------------
DavesTimerApp: command-line-interface
-------------------------------------
Timer (1), Alarm (2), Remove (3)
..?
```
You can either add a timer (minutes or hours:minutes), an alarm (24h time format), or remove existing timers.

The app is integrated with i3blocks. There will be a blocklet with the date, time, and countdown for when the 
timer will go off. Example: `09/21 - 14:27 - 01:20```
