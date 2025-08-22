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

  echo "$(date -d \"@$NEXT\")"
  echo "$(date -d \"@$NEXT\")"
  echo "#AAAAAA"
else
  echo "no active timers"
  echo "no active timers"
  echo "#AAAAAA"
fi
