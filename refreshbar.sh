#!/bin/bash

# sleep 0.02s
kill "$(pstree -lp | grep autostart | sed "s/.*sleep(\([0-9]\+\)).*/\1/")"
