#!/usr/bin/perl
use 5.020;
my $res;
$res += $_ for map {
	my @p = split /\n/;
	my $c = int @p;
	my %h;
	++$h{$_} for map { split // } @p;
	int grep { $h{$_} == $c } keys %h;
} do { local $/="\n\n"; <> };
say $res;
