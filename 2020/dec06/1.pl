#!/usr/bin/perl
use 5.020;
my $n;
$n += int keys %$_ for map {
	{ map { $_ => 1 } /([a-z])/g }
} do { local $/="\n\n"; <>};
say $n;
