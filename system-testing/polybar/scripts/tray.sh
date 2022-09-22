#!/usr/bin/env bash

#echo "---" | tee -a /tmp/polybar2.log
polybar tray --config=~/.config/polybar/tray-bar.ini >> /tmp/polybar2.log 2>&1

