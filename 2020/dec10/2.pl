#!/usr/bin/perl
use 5.020;
my @ints = (0, sort { $a <=> $b } map { int } <>);

my %r = ($ints[0] => 1);
for my $n (@ints) {
	$r{$n} += $r{$n-$_} // 0 for 1..3;
}

say $r{$ints[$#ints]};
