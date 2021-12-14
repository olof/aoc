#!/usr/bin/raku
my @in = $*IN.lines.head.split(',').map(*.Int).sort;
my $t = @in[@in.elems div 2];
@in.map({ abs($_ - $t) }).sum.say;
