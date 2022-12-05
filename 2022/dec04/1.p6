#!/usr/bin/raku
$*IN.lines.map({.trim}).map({
  my ($a, $b) = .split(",").map({
    my ($low, $high) = .split("-");
    ($low.Int .. $high.Int).Set
  });
  $a ⊆ $b or $b ⊆ $a
}).sum.say;
