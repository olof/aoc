#!/usr/bin/perl
use 5.020;
use Data::Dumper;
use List::Util qw(first sum);
$" = $, = ", ";
my @in = <> =~ /(\S)/g;

my @map = map {
	($_ & 1) ? [0, $in[$_], -1]
	         : [1, $in[$_], $_ / 2]
} keys @in;

my @blocks = map { ($_->[0] ? \($_->[2]) : undef) x $_->[1] } @map;

sub render {
	local $,;
	print $_ ? $$_ : '.' for @_;
	print "\n";
}

my $done = 0;
while (1) {
	my $elm = pop @blocks or next;
	my $free = first { not defined $blocks[$_] }
	           $map[0]->[1] + $done..$#blocks;
	if (not $free) {
		push @blocks, $elm;
		last unless $free;
	}
	$blocks[$free] = $elm;
	++$done;
}
push @blocks, (undef) x $done;
my @data = map { $$_ } grep { ref $_ } @blocks;
say sum map { $_ * $data[$_] } keys @data;
