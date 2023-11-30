#!/bin/bash

set -o pipefail

if ! bluetoothctl show | grep -q 'Powered: yes' ; then
   echo '%{F#505050}'
elif dev=$( bluetoothctl info | grep 'Alias:' ) ; then
   echo "%{F#457db2} %{F#c8ced5}${dev/*Alias: /}"
else
   echo '%{F#c8ced5}'
fi
