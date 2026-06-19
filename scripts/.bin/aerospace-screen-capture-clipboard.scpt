#!/usr/bin/env osascript

set titleText to "Capture"

display notification "Choose screenshot region" with title titleText
do shell script "/usr/sbin/screencapture -i -c"
display notification "Screenshot copied" with title titleText
