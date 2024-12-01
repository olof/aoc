#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
use List::MoreUtils qw(zip6);
my (@a, @b);
for my $pair (map { [map { int } split / +/] } <>) {
	push @a, $pair->[0];
	push @b, $pair->[1];
}
@a = sort @a;
@b = sort @b;
say sum(map { abs $_->[0] - $_->[1] } zip6(@a, @b));
