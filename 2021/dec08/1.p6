#!/usr/bin/raku

my %len_maps =
  2 => 1,
  3 => 7,
  4 => 4,
  5 => 2 | 3 | 5,
  6 => 0 | 6 | 9,
  7 => 8,
;

$*IN.lines.map(*.split(' | ').tail.words).map(
  *.map(*.chars).map({ %len_maps{$_} }).grep({ $_.^name ne 'Junction' }).elems
).sum.say
