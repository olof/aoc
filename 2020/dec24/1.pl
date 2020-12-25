#!/usr/bin/perl;
use 5.020;

sub move {
	my($a, $b) = @_;
	sub { $_[0] + $a, $_[1] + $b }
}

my %moves = (
	nw => move(-1, -1),
	ne => move( 0, -1),
	sw => move( 0,  1),
	se => move( 1,  1),
	 e => move( 1,  0),
	 w => move(-1,  0),
);

my %state;
while (<>) {
	my ($x, $y) = (0, 0);
	($x, $y) = $moves{$_}->($x, $y) for /(nw|ne|sw|se|e|w)/g;
	$state{"$x,$y"} ^= 1;
}

say int grep { $_ == 1 } values %state;
