#!/bin/sh
. utils.sh

read times
read dists
t=$(printf %d ${times#Time: })
d=$(printf %d ${dists#Distance: })
n=1
highest= lowest=
scan_speed=512000

while [ $n -lt $t ]; do
	res=$(( (t-n) * n ))

	if [ $res -gt $d ]; then
		n2=$n
		while [ $(( (t-n2)*n2 )) -gt $d ]; do
			n2=$((n2-1))
		done
		lowest=$((n2+1))
		break
	fi
	n=$((n+scan_speed))
done

while [ $n -lt $t ]; do
	res=$(( (t-n) * n ))

	if [ $res -le $d ]; then
		n2=$n
		while [ $(( (t-n2)*n2 )) -le $d ]; do
			n2=$((n2-1))
		done
		highest=$((n2))
		break
	fi

	n=$((n+scan_speed))
done

[ "$lowest" ] || {
	n2=1
	while [ $n2 -le $scan_speed ] && [ $(((t-n2)*n2)) -lt $d ]; do
		n2=$((n2+1))
	done
	lowest=$n2
}

[ "$highest" ] || {
	n2=$((t-1))
	while [ $(( (t-n2)*n2 )) -le $d ]; do
		n2=$((n2-1))
	done
	highest=$n2
}

echo $((highest-lowest + 1))
