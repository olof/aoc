#!/bin/sh
. utils.sh
sed -re '
s/^((.)\2\2\2\2) (.+)/five_of_a_kind \1 \3/
s/^(.(.)\2+|(.)\3*[^ ]\3*) (.+)/four_of_a_kind \1 \4/
s/^((.)\2*(.)\3*\2*\3*\2*) (.+)/full_house \1 \4/

s/^([^ ]*(.)\2\2.*) (.+)/three_of_a_kind \1 \3/
s/^([^ ]*([0-9TJQKA])[^ ]*\2[^ ]*\2[^ ]*) (.+)/three_of_a_kind \1 \3/

s/^((.)\2(.)\3.) (.+)/two_pair \1 \4/
s/^((.)\2(.).\3) (.+)/two_pair \1 \4/
s/^((.)\2.(.)\3) (.+)/two_pair \1 \4/
s/^((.).\2(.)\3) (.+)/two_pair \1 \4/
s/^((.)(.)\2\3.) (.+)/two_pair \1 \4/
s/^((.)(.)\2.\3) (.+)/two_pair \1 \4/
s/^((.)(.).\2\3) (.+)/two_pair \1 \4/
s/^((.)(.)\3\2.) (.+)/two_pair \1 \4/
s/^((.)(.)\3.\2) (.+)/two_pair \1 \4/
s/^((.)(.).\3\2) (.+)/two_pair \1 \4/
s/^((.).(.)\2\3) (.+)/two_pair \1 \4/
s/^((.).(.)\3\2) (.+)/two_pair \1 \4/
s/^(.(.)(.)\3\2) (.+)/two_pair \1 \4/
s/^(.(.)(.)\2\3) (.+)/two_pair \1 \4/
s/^(.(.)\2(.)\3) (.+)/two_pair \1 \4/

s/^([^ ]*([0-9TJQKA])[^ ]*\2[^ ]*) (.+)/two_of_a_kind \1 \3/

s/^([0-9TJQKA]+) (.+)/high_card \1 \2/

s/^([0-9TJQKA].*)/error \1/

s/^five/5.0 five/
s/^four/4.0 four/
s/^full/3.1 full/
s/^three/3.0 three/
s/^two/2 two/
s/^high_/0 high/

s/A/E/g
s/K/D/g
s/Q/C/g
s/J/B/g
s/T/A/g
' | sort -n | nl |
  case $DEBUG in
    y) awk '{printf "%4d  %16s %5s %5d %d\n", $1, $3, $4, $5, $1 * $5}' |
       sed -re 's/A/T/g; s/B/J/g; s/C/Q/g; s/D/K/g; s/E/A/g' ;;
    *) awk '{print $1 * $5}' | sum ;;
  esac
