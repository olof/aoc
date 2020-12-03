#!/usr/bin/perl
use 5.020;

sub parse { shift; [/^([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)$/] }
sub valid {
	my ($min, $max, $ch, $p) = @{shift()};
	return $p =~ /^[^${ch}]*(?:${ch}[^${ch}]*){$min,$max}$/;
}

say int grep { valid($_) } map { parse($_) } <>;
