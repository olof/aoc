#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
my (@a, %b);
for my $pair (map { [map { int } split / +/] } <>) {
	push @a, $pair->[0];
	++$b{$pair->[1]};
}
say sum(map { abs $_ * $b{$_} } @a);
