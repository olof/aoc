#!/bin/sh
score=0
sort | uniq -c | {
	while read count hands; do
		outcome=$(echo "$hands" | perl -pe '
			s/A X/4/;
			s/A Y/8/;
			s/A Z/3/;
			s/B X/1/;
			s/B Y/5/;
			s/B Z/9/;
			s/C X/7/;
			s/C Y/2/;
			s/C Z/6/;
		')
		score=$(($score + $count * $outcome))
	done
	echo $score
}
