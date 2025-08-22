#!/usr/bin/bash
#
#
#
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"
echo -e "\nDavesTimerApp: command-line-interface\n"
echo "(* means optional)"
echo "-------------------------------------"


echo -en "Timer (1) or Alarm (2) \n..? "
read -r CHOICE

if [[ $CHOICE == 1 ]]; then
  echo -en "Enter time (hrs*/min) \n..? "
  read -r TIMER

  MINUTES="$(echo "$TIMER" | awk -F/ '{print $2}')"
  if [[ -z $MINUTES ]]; then
    MINUTES="$(echo "$TIMER" | awk -F/ '{print $1}')"
    HOURS="0"
  else
    HOURS="$(echo "$TIMER" | awk -F/ '{print $1}')"
  fi

  # amount of seconds to be elapsed + seconds since the Epoch
  TIMER=$(($HOURS * 60 * 60 + $MINUTES * 60 + $(date +%s)))

  touch "$SCRIPT_PATH/current_timers/$TIMER"

elif [[ $CHOICE == 2 ]]; then
  echo "2"
else
  echo "Invalid choice!" >&2
  exit
fi

