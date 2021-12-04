#!/usr/bin/raku
say [«*»] (
  reduce -> @s, &cb { &cb(@s) }, (0, 0, 0),
  |map -> ($_, $v) {
     when 'forward' { sub (($a, $h, $d)) { ($a, $h+$v, $d+$a*$v) } }
     when 'up'      { sub (($a, $h, $d)) { ($a-$v, $h, $d) } }
     when 'down'    { sub (($a, $h, $d)) { ($a+$v, $h, $d) } }
   },
   map -> $_ {.words}, $*IN.lines;
).tail(2)
