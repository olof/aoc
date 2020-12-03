#!/usr/bin/perl
use 5.020;

sub parse { shift; [/^([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)$/] }
sub valid {
	my ($i1, $i2, $ch, $p) = @{shift()};
	my @ch = split //, $p;
	return (($ch[$i1-1] eq $ch) xor ($ch[$i2-1] eq $ch));
}

say int grep { valid($_) } map { parse($_) } <>;
