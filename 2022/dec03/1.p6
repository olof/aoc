#!/usr/bin/raku
my %scores = ('a'..'z', 'A'..'Z').flat.kv.reverse.hash;
$*IN.lines.map({.trim}).map({
  (.substr(0, .chars/2).ords.Set ∩ .substr(.chars/2).ords.Set ).keys.first;
}).map({%scores{.first.chr} + 1}).sum.say;
