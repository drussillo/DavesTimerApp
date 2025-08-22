#!/usr/bin/bash
#
# simple timer app
#
#
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"
TIMERS="$(ls $SCRIPT_PATH/current_timers/)"

if [[ -n $TIMERS ]]; then
  CURRENT_TIME="$(date +%s)"

  # next timer (to display)
  NEXT=$(echo "$TIMERS" | awk 'NR==1')

  # go through all timer files
  while [[ -n $TIMERS ]]; do
    CURRENT=$NEXT

    # one of the timers < current time
    if [[ $CURRENT < $(date +%s) ]]; then
      # delete timer & alert user
      rm $SCRIPT_PATH/current_timers/$CURRENT
      ffplay -nodisp -autoexit $SCRIPT_PATH/alert_sounds/city_alert_siren.wav
      # INSERT USER SPECIFIED EFFECTS HERE
    fi

    TIMERS=$(echo "$TIMERS" | tail -n +2)
  done

  # for i3blocks
  DISPLAY="$(date -d "@$NEXT" +%m/%d\ -\ %H:%M) - "

  # make sure time left is diplayed in 00:00 instead of 0:0
  MINUTES=$((($NEXT-$CURRENT_TIME) / 60))
  SECONDS=$((($NEXT-$CURRENT_TIME) % 60))

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
  echo "no active timers"
  echo "no active timers"
  echo "#AAAAAA"
fi
