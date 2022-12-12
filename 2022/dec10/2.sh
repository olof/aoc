#!/bin/sh
acc=1
echo
sed -r -e '1i0' \
       -e 's/noop/0/' \
       -e 's/addx (-?[0-9]+)/0\n\1/' | {
	while read n; do
		acc=$((acc+n))
		echo $acc $(($acc+1)) $(($acc+2))
	done | nl | while read p s0 s1 s2; do
		case $(($p % 40)) in
			$s0|$s1|$s2) printf '#' ;;
			*) printf ' ' ;;
		esac
		[ $(($p % 40)) -ne 0 ] || echo
	done
}
