#!/usr/bin/bash
#
#
#
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"
echo "-------------------------------------"
echo "DavesTimerApp: command-line-interface"
echo "-------------------------------------"


echo -en "Timer (1), Alarm (2), Remove (3) \n..? "
read -r CHOICE

if [[ $CHOICE == 1 ]]; then
  echo -en "\nEnter time (h:m) \n..? "
  read -r TIMER

  MINUTES="$(echo "$TIMER" | awk -F: '{print $2}')"
  if [[ -z $MINUTES ]]; then
    MINUTES="$(echo "$TIMER" | awk -F: '{print $1}')"
    HOURS="0"
  else
    HOURS="$(echo "$TIMER" | awk -F: '{print $1}')"
  fi

  # amount of seconds to be elapsed + seconds since the Epoch
  TIMER=$(($HOURS * 60 * 60 + $MINUTES * 60 + $(date +%s)))

  touch "$SCRIPT_PATH/current_timers/$TIMER"

  echo "New timer: $(date -d "@$TIMER" +%m/%d\ -\ %H:%M:%S) - $((($TIMER - $(date +%s)) / 60))min remaining"
  exit

elif [[ $CHOICE == 2 ]]; then
  echo -en "\nEnter time (hh:mm, 24hrs) \n..? "
  read -r TIMER

  POSSIBLE_TIMER="$(date -d "$TIMER" +%s)"
  if [[ $POSSIBLE_TIMER -lt "$(date +%s)" ]]; then
    POSSIBLE_TIMER=$(($POSSIBLE_TIMER + 24 * 60 * 60))
  fi
  echo -e "\nTIMER: $(date -d "@$POSSIBLE_TIMER" +%I:%M\ %p\ \(%H:%M\)\ \o\n\ %m/%d)"
  echo -en "(date mm/dd) \n..? "
  read -r NEW_DATE
  if [[ -n "$NEW_DATE" ]]; then
    POSSIBLE_TIMER="$(date -d "$NEW_DATE $(date -d "@$POSSIBLE_TIMER" +%H:%M)")"
    echo "$POSSIBLE_TIMER"
  fi

  #TODO
  exit

elif [[ $CHOICE == 3 ]]; then

  echo
  TIMERS="$(ls $SCRIPT_PATH/current_timers/)"
  if [[ -n $TIMERS ]]; then
    echo -e "\nCurrent Timers:"

    # Display all timers in right format

    TEMP=$(echo "$TIMERS" | awk 'NR==1')
    echo "$TEMP"
    i=1
    while [[ -n $TEMP ]]; do
      echo "($i)  $(date -d "@$TEMP" +%m/%d\ -\ %H:%M:%S) - $((($TEMP - $(date +%s)) / 60))min remaining"
      i=$(($i+1))
      TEMP=$(echo "$TIMERS" | awk -v line="$i" 'NR==line')
    done
    echo -e "($i)  All\n"

    echo -en "Pick an option to delete \n..? "
    read -r CHOICE
    echo

    # all option
    if [[ $CHOICE == $i ]]; then
      rm $SCRIPT_PATH/current_timers/1*
      echo "All timers have been cleared"
      exit
    elif [[ $CHOICE > $i || $CHOICE < 1 ]]; then
      echo "Invalid timer entry" >&2
    else
      rm $SCRIPT_PATH/current_timers/$(echo "$TIMERS" | awk -v line="$CHOICE" 'NR==line')
      echo "Timer ($CHOICE) has been cleared"
      exit
    fi

  else
    echo "No timers currently active."
    exit
  fi

else
  echo "Invalid choice!" >&2
  exit
fi

