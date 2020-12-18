#!/usr/bin/perl
use 5.020;

sub count {
	my $state = shift;
	my %count;
	for my $z (keys %$state) {
		for my $x (keys %{$state->{$z}}) {
			for my $y (keys %{$state->{$z}->{$x}}) {
				for ([-1, -1, -1], [-1, -1, -0], [-1, -1, +1],
				     [-1,  0, -1], [-1,  0, -0], [-1,  0, +1],
				     [-1, +1, -1], [-1, +1, -0], [-1, +1, +1],
				     [ 0, -1, -1], [ 0, -1, -0], [ 0, -1, +1],
				     [ 0,  0, -1],               [ 0,  0, +1],
				     [ 0, +1, -1], [ 0, +1, -0], [ 0, +1, +1],
				     [+1, -1, -1], [+1, -1, -0], [+1, -1, +1],
				     [+1,  0, -1], [+1,  0, -0], [+1,  0, +1],
				     [+1, +1, -1], [+1, +1, -0], [+1, +1, +1]) {
					$count{$z + $_->[0]}->
					      {$x + $_->[1]}->
					      {$y + $_->[2]} //= 0;
					next if $state->{$z}->{$x}->{$y} ne '#';
					++$count{$z + $_->[0]}->
					        {$x + $_->[1]}->
					        {$y + $_->[2]}
				}
			}
		}
	}
	return %count;
}

sub mutate {
	my $state = shift;
	my $count = shift;
	for my $z (keys %$count) {
		my $dim_v = $state->{$z};
		my $dim_n = $count->{$z};
		for my $x (keys %$dim_n) {
			my $row_v = $dim_v->{$x};
			my $row_n = $dim_n->{$x};
			for my $y (keys %$row_n) {
				my $s = $row_v->{$y};
				my $c = $row_n->{$y};
				$state->{$z}->{$x}->{$y} = $s eq '#' ?
					($c ^ 2) < 2 ? '#' : '.' :
					$c - 3 ? '.' : '#';
			}
		}
	}
}

my %state = ( 0 => { do {
	my %ret;
	while (<>) {
		chomp;
		my @cols = split //;
		$ret{$.-1} = { map { $_ => $cols[$_] } 0..$#cols };
	}
	%ret;
}});

mutate \%state, {count \%state} for 1..6;

say eval join '+' => map { 1 } grep { $_ eq '#' }
                     map { values %$_ }
                     map { values %$_ }
                     values %state;
