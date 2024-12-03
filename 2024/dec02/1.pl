#!/usr/bin/perl
use 5.020;
use List::Util qw(all);
$"=",";
say int grep {
	my @s = @$_;
	my $cmp = $s[0] <=> $s[1];
	all {
		my $d = abs($s[$_-1] - $s[$_]);
		($s[$_-1] <=> $s[$_]) == $cmp and $d > 0 and $d < 4
	} 1..$#$_
} map { [ map { int } split ] } <>;
