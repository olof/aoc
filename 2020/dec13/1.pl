#!/usr/bin/perl
use 5.020;
my $t = int <>;
my @b = map { (int($t / $_)+1) * $_ - $t . "*$_" }
        grep { $_ } map { int } do { local $/=","; <> };
my $r = 2**32;
do { $r = $_ if $r >= $_ } for @b;
say eval $r;
