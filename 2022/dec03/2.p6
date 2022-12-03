#!/usr/bin/raku
my %scores = ('a'..'z', 'A'..'Z').flat.kv.reverse.hash;
$*IN.lines.map({.trim}).batch(3).map({
  ([∩] .map({.ords.Set})).keys.first.chr
}).map({%scores{$_} + 1}).sum.say;
