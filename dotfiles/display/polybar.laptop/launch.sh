#!/usr/bin/env bash

killall -q polybar
while pgrep --euid $UID --exact polybar >/dev/null ; do
   sleep 0.25
done

polybar main &
disown
