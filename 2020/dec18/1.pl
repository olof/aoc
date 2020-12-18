#!/usr/bin/perl
use 5.020;
sub solve {
	local $_ = shift;
	s/\s*\(\s*([^\(\)]+?)\s*\)\s*/solve($1)/e while /\(/;
	s/([0-9]+)\s*([+*])\s*([0-9]+)/"$1$2$3"/ee while /[+*]/;
	return $_;
}

my $sum;
$sum += solve($_) while <>;
say $sum;
