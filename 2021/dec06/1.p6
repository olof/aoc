#!/usr/bin/raku
$_ = $*IN.lines.head;

for 1..80 -> $day {
  s:g/0/7,9/;
  s:g/(<[0..9]>)/{ $0 - 1 }/;
}
.split(",").elems.say;
