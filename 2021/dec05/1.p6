#!/usr/bin/raku
my %ridges;
%ridges{$_.join("x")} += 1 for $*IN.lines.map(
  *.split(' -> ').map(*.split(',').map(*.Int).list).list
).grep(
  -> (($x1, $y1), ($x2, $y2)) { $x1 == $x2 or $y1 == $y2 }
).map(
  { ([Z] $_).map({ [...] $_ }) }
).map(
  { | [<<,>>] $_ }
);
%ridges.values.grep({ $_ > 1 }).elems.say;
