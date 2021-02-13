#!/bin/bash

sleep 0.1s
kill "$(pstree -lp | grep autostart | sed "s/.*sleep(\([0-9]\+\)).*/\1/")"
