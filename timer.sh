#!/usr/bin/bash
#
# simple timer app
#
#
CURRENT_TIME="$(date +%s)"
TIMERS="$(ls ./current_timers/)"

while [[ -n $TIMERS ]]; do
  CURRENT=$(echo "$TIMERS" | awk 'NR==1')

  # one of the timers < current time
  if [[ $CURRENT < $(date +%s) ]]; then
    # delete timer & alert user
    rm ./current_timers/$CURRENT
    ffplay -nodisp -autoexit ./alert_sounds/city_alert_siren.wav
    # INSERT USER SPECIFIED EFFECTS HERE
  fi

  TIMERS=$(echo "$TIMERS" | tail -n +2)
done

