#!/bin/bash

while true; do
  available_updates=$(checkupdates | wc -l 2>/dev/null)
  if [[ $available_updates > 0 ]]; then
    notify-send\
    -u normal\
    --icon=/usr/share/icons/Numix/48/actions/package-new.svg\
    "Heads Up!"\
    "${available_updates} available updates"
  fi
  sleep 60m
done
