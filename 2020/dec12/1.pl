#!/usr/bin/perl
use 5.020;
my @in = map { [/^([A-Z])([0-9]+)$/] } <>;
my $face = 'E';
my ($x, $y) = (0, 0);

my %faces = (
	E => { L => 'N', R => 'S'},
	W => { L => 'S', R => 'N'},
	N => { L => 'W', R => 'E'},
	S => { L => 'E', R => 'W'},
);
my %signs = ( E => +1, W => -1, N => -1, S => +1, );

{
	S => sub { $y += pop },
	N => sub { $y -= pop },
	E => sub { $x += pop },
	W => sub { $x -= pop },
	F => sub { $face =~ /^[EW]$/ ?
		$x += $signs{$face} * pop :
		$y += $signs{$face} * pop
	},
	# this also works because we just care about sums:
	#F => sub { $y += $signs{$face} * pop },
	R => sub { $face = $faces{$face}->{R} for 1..pop()/90 },
	L => sub { $face = $faces{$face}->{L} for 1..pop()/90 },
}->{$_->[0]}->($_->[1]) for @in;

say abs($x) + abs($y);
