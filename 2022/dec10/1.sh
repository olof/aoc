#!/bin/sh
acc=1
echo $(( $(sed -r \
  -e '1i0' \
  -e 's/noop/0/' \
  -e 's/addx (-?[0-9]+)/0\n\1/' | while read n; do
	acc=$((acc+n))
	echo $acc
done | sed -n -e  '20s/$/*20+/p' \
              -e  '60s/$/*60+/p' \
              -e '100s/$/*100+/p' \
              -e '140s/$/*140+/p' \
              -e '180s/$/*180+/p' \
              -e '220s/$/*220/p') ))
