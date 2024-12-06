#!/usr/bin/perl
use 5.020;
my @in = map { [grep { /[A-Z0-9_.]/i } split //] } <>;
for my $i (1..$#in-1) {
	$_ +=
	  grep { /^(?:SAM|MAS) (?:SAM|MAS)$/ }
	  map { "$in[$i-1]->[$_-1]A$in[$i+1]->[$_+1] " .
	        "$in[$i-1]->[$_+1]A$in[$i+1]->[$_-1]" }
	  grep { $in[$i]->[$_] eq 'A' }
	  grep { say STDERR }
	  1 .. $#{$in[$i]} - 1
}
say;
