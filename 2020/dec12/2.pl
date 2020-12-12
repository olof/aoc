#!/usr/bin/perl
use 5.020;
my @in = map { [/^([A-Z])([0-9]+)$/] } <>;
my @wp = (10, -1);
my @pos = (0, 0);

{
	S => sub { $wp[1] += pop },
	N => sub { $wp[1] -= pop },
	E => sub { $wp[0] += pop },
	W => sub { $wp[0] -= pop },
	R => sub { unshift @wp, -pop @wp for 1 .. pop() / 90 },
	L => sub { push @wp, -shift @wp for 1 .. pop() / 90 },
	F => sub { $pos[$_] += $_[0] * $wp[$_] for 0, 1 }
}->{$_->[0]}->($_->[1]) for @in;

say abs($pos[0]) + abs($pos[1]);
