#!/bin/sh
sum() { n=0; while read line; do n=$((n+line)); done; echo $n; }
flush_partid() {
	[ -z "$partid" ] && return
	n=$partid_start
	while [ $n -lt $col ]; do
		echo partid $partid $line $n $partid_start
		n=$((n+1))
	done
	partid=
	partid_start=
}

sed -re 's/(.)/\1 /g; s/\s*$//' | {
	line=0
	while read input; do
		line=$((line+1)) col=0
		digit=
		digit_start=
		while test -n "$input"; do
			ch=${input%%\ *} new_input=${input#*\ } col=$((col+1))
			[ "$new_input" != "$input" ] || new_input=
			input=$new_input

			case $ch in [!0-9]) flush_partid ;; esac
			case $ch in
			        .) ;;
				[0-9]) partid=$partid$ch
				       partid_start=${partid_start:-$col} ;;
				*)     echo part "$ch" $line $col $col ;;
			esac
		done
		flush_partid
	done
} | sort -r | while read type val line col start; do
	case $type in
		partid)
			eval cell_${line}_${col}="\\\$partid_${line}_$start"
			eval partid_${line}_${start}=$val
			;;
		part)
			eval "
echo \$cell_$((line-1))_$((col-1))
echo \$cell_$((line-1))_$((col))
echo \$cell_$((line-1))_$((col+1))
echo \$cell_$((line))_$((col-1))
echo \$cell_$((line))_$((col+1))
echo \$cell_$((line+1))_$((col-1))
echo \$cell_$((line+1))_$((col))
echo \$cell_$((line+1))_$((col+1))" | grep . | uniq | while read hit; do
				eval echo $hit
			done
			;;
	esac
done | sum
