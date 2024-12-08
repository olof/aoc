#!/usr/bin/perl
use 5.020;
use List::Util qw(sum any);

sub solve {
	my $t = shift;
	my $n = shift;
	return 0 if $n > $t;
	return 0 if not @_ and $t != $n;
	return 1 if not @_;
	my $i = shift;
	any { solve($t, $_, @_) } $n + $i,
	                          $n * $i,
	                          $n . $i
}

say sum
    map { $_->[0] }
    grep { solve(@$_) }
    map { [/\b([0-9]+)\b/g] }
    <>;
