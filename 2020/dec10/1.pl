#!/usr/bin/perl
use 5.020;
my @ints = sort { $a <=> $b } map { int } <>;
my ($j, $x1, $x3) = (0, 0, 0);
do {
	++${{1 => \$x1, 3 => \$x3}->{$_-$j}};
	$j = $_;
} for @ints;
say $x1 * ($x3 + 1);
