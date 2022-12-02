#!/bin/sh
perl -pe '
	s/A X/A Z/ or
	s/A Y/A X/ or
	s/A Z/A Y/ or
	s/B X/B X/ or
	s/B Y/B Y/ or
	s/B Z/B Z/ or
	s/C X/C Y/ or
	s/C Y/C Z/ or
	s/C Z/C X/
' | sh 1.sh
