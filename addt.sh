#!/usr/bin/bash
#
#
#
echo -en "Timer (1) or Alarm (2) \n..? "
read -r CHOICE

if [[ $CHOICE == 1 ]]; then
  echo -en "Enter time (min) \n..? "
  read -r TIMER

  echo "./current_timers/$(($TIMER * 60 + $(date +%s)))"

elif [[ $CHOICE == 2 ]]; then
  echo "2"
else
  echo "Invalid choice!" >&2
  exit
fi

