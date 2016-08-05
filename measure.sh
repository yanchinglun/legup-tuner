#! /bin/bash

cd ..
rm config.tcl
cp tuner/config.tcl .
2>/dev/null 1>/dev/null make
CYCLES=$(2>/dev/null make v | grep Cycles: | awk 'BEGIN { FS = " " } ; { print $3 }')
if [[ -z $CYCLES ]]; then
    echo 'ERROR OCURRED'
    exit 0
else
    echo $CYCLES
    2>/dev/null 1>/dev/null make p
    2>/dev/null 1>/dev/null make f
    grep '^; [0-9]\+.[0-9]\+ MHz' top.sta.rpt | awk 'BEGIN { FS = ";" } ; { print $2 }'
fi
