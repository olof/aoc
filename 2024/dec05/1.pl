#!/usr/bin/perl
use 5.020;
use List::Util qw(sum all);

sub parse {
	my ($deps, $p1, $p2) = ({}, do { local $/ = ""; <> });
	for (map { [split /\|/, $_] } split /\n/, $p1) {
		$deps->{$_->[0]} //= {};
		$deps->{$_->[0]}->{$_->[1]} = 1;
	}
	$deps, [map { [split ','] } split /\n/, $p2],
}

sub check {
	my $deps = shift;
	my %x;
	all {
		$x{$_} = 1 for keys %{$deps->{$_} // {}};
		$x{$_} ? 0 : ($x{$_} = 1)
	} reverse @_;
}

my ($deps, $updates) = parse;
say sum map { $_->[$#$_/2] } grep { check($deps, @$_) } @$updates;
