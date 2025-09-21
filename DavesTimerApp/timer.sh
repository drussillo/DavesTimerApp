#!/usr/bin/bash
#
#
#
SCRIPT_PATH="${HOME}/.config/i3blocks/scripts/DavesTimerApp"
NEXT_TIMER="$(ls -X $SCRIPT_PATH/current_timers/ | awk 'NR==1')"

if [[ -n "$NEXT_TIMER" ]]; then
  CURRENT_TIME="$(date +%s)"

  if [[ $NEXT_TIMER -lt $CURRENT_TIME ]]; then
    # delete timer & alert user
    rm $SCRIPT_PATH/current_timers/$NEXT_TIMER
    # INSERT USER SPECIFIED EFFECTS HERE
    #
    #
    redshift -O 1000
    ffplay -nodisp -autoexit $SCRIPT_PATH/alert_sounds/city_alert_siren.wav
    #
    #
    #
  fi

  # for i3blocks
  DISPLAY="$(date -d "@$NEXT_TIMER" +%m/%d\ -\ %H:%M) - "

  HOURS=$((($NEXT_TIMER - $CURRENT_TIME) / 60 / 60))
  MINUTES=$(((($NEXT_TIMER - $CURRENT_TIME) / 60) % 60))
  SECONDS=$((($NEXT_TIMER - $CURRENT_TIME) % 60))

  # only display hours if necessary
  if [[ $HOURS > 0 ]]; then
    DISPLAY+="$HOURS:"
  fi

  # make sure time left is diplayed in 00:00 instead of 0:0
  if [[ $MINUTES -lt 10 ]]; then
    DISPLAY+="0$MINUTES:"
  else
    DISPLAY+="$MINUTES:"
  fi
  if [[ $SECONDS -lt 10 ]]; then
    DISPLAY+="0$SECONDS"
  else
    DISPLAY+="$SECONDS"
  fi

  echo "$DISPLAY"
  echo "$DISPLAY"
  echo "#AAAAAA"
else
  echo "(addt) no active timers"
  echo "no active timers"
  echo "#AAAAAA"
fi
