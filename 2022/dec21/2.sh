#!/bin/sh
simple='
%s:
	printf '\''%%s'\'' %s > $@
'
arith='
%s: %s %s
	printf "(%%s)" "$$(sed -e 1a'\'%s\'' $^ | tr -d "\\n")" > $@
'
root='
%s: %s %s
	sed -e 1a'\'%s\'' $^; echo
'


tmpd=$(mktemp -d /tmp/aoc-dec21-XXXXXX)
trap 'rm -rf "$tmpd"' EXIT
math=$({
	while read target recipe; do
		t=${target%:}
		[ $t != humn ] || recipe="'\$\$X'"
		case $recipe in
			????\ [+/*-]\ ????)
				d1=${recipe%% *}
				d2=${recipe##* }
				op=${recipe#* }
				op=${op% *}
				if [ $t = root ]; then
					printf "$root" "$t" "$d1" "$d2" "'-'"
				else
					printf "$arith" "$t" "$d1" "$d2" "'$op'"
				fi
				;;
			[0-9]|[0-9][0-9]|"'\$\$X'")
				printf "$simple" "$t" "$recipe"
				;;
		esac
	done
	echo
	echo .PHONY: root
} | make -C$tmpd -f- root | while read expr; do
	case $expr in
		*'$X'*) echo "$expr" | perl -pe '
		  while (
		    s/(\d+)([+\/\*-])(\d+)/"$1 $2 $3"/eeg or
		    s/\((\d+)\)/$1/g or
		    s/\([^)]+\/(\d+)\)([+-])/\1\2/g
		  ) {
		    1
		  }
		' ;;
		-) ;;
		*) echo -$(( $expr )) ;;
	esac
done | tr -d "\n"; echo)

X=1
minx=0
maxx=446744073709551
while :; do
	eval "res=\$(($math))"
	[ "$res" != 0 ] || break
	if [ $res -gt 0 ]; then
		[ "$minx" -gt "$X" ] || minx=$X
	else
		[ "$maxx" -lt "$X" ] || maxx=$X
	fi
	X=$(( minx + ((maxx-minx)/2) ))
done

while :; do
	res="$(perl -Mbignum -E "my \$X = shift; say $math" "$X")"
	case $res in
		*.*) X=$((X-1)) ;;
		*) echo $X && exit 0
	esac
done
