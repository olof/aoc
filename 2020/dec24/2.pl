#!/usr/bin/perl;
use 5.020;

sub neighbors {
	my ($x, $y) = @_;
	($x, $y) = split /,/, $x unless $y;
	return map { join(",", @$_) }
		[$x-1, $y-1], [$x-1, $y+0],
	        [$x+0, $y-1], [$x+0, $y+1],
		[$x+1, $y+0], [$x+1, $y+1]
}

sub move {
	my($a, $b) = @_;
	sub { $_[0] + $a, $_[1] + $b }
}

my %moves = (
	nw => move(-1, -1),
	ne => move(+0, -1),
	sw => move(+0, +1),
	se => move(+1, +1),
	 e => move(+1, +0),
	 w => move(-1, +0),
);

my %state;
while (<>) {
	my ($x,$y) = (0,0);
	($x,$y) = $moves{$_}->($x,$y) for /(nw|ne|sw|se|e|w)/g;
	$state{"$x,$y"} ^= 1;
}

my $res;
for (1..100) {
	my %stage = %state;
	for my $pos (grep { $state{$_} == 1 } keys %state) {
		my @neighbors = neighbors($pos);
		my @off = grep { not $state{$_} } @neighbors;
		my $on = @neighbors-@off;

		$stage{$pos} = 0 if $on > 2 or not $on;
		$stage{$_} = 1 for
			grep { 2 == grep { $state{$_} } neighbors($_) } @off;
	}
	%state = %stage;
	$res = int grep { $_ == 1 } values %state;
}

say $res;
