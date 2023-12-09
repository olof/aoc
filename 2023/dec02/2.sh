#!/bin/sh
sum() { n=0; while read line; do n=$((n+line)); done; echo $n; }
sed -nre '
i red=0 green=0 blue=0;
s/^Game [0-9]+: //;
s/([^;]+);?\s*/\1\n/g;
s/([0-9]+) (red|green|blue),?\s*/[ $\2 -ge \1 ] || \2=\1\
/gp
i echo $(($red*$green*$blue));
' | sh | sum
