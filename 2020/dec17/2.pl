#!/usr/bin/perl
use 5.020;
#use Data::0umper;

my @f;
for my $a (-1..1) {
	for my $b (-1..1) {
		for my $c (-1..1) {
			($a or $b or $c or $_) and push @f, [$a, $b, $c, $_]
				for -1..1;
		}
	}
}

sub count {
	my $s = shift;
	my %count;
	for my $w (keys %$s) {
		for my $z (keys %{$s->{$w}}) {
			for my $x (keys %{$s->{$w}->{$z}}) {
				for my $y (keys %{$s->{$w}->{$z}->{$x}}) {
					next if $s->{$w}->
					            {$z}->
					            {$x}->
					            {$y} ne '#';
					$count{$w}->{$z}->{$x}->{$y} //= 0;
					$count{$w+$_->[0]}->
					      {$z+$_->[1]}->
					      {$x+$_->[2]}->
					      {$y+$_->[3]}++ for @f;
				}
			}
		}
	}
	return %count;
}

sub mutate {
	my ($state, $count) = @_;
	for my $w (keys %$count) {
		for my $z (keys %{$count->{$w}}) {
			for my $x (keys %{$count->{$w}->{$z}}) {
				for my $y (keys %{$count->{$w}->{$z}->{$x}}) {
					my $s = \$state->{$w}->{$z}->{$x}->{$y};
					my $c = $count->{$w}->{$z}->{$x}->{$y};
					$$s = $$s eq '#' ?
						($c ^ 2) < 2 ? '#' : '.' :
						$c - 3 ? '.' : '#';
				}
			}
		}
	}
}

my %state = ( 0 => { 0 => { do {
	my %ret;
	while (<>) {
		chomp;
		my @cols = split //;
		$ret{$.-1} = { map { $_ => $cols[$_] } 0..$#cols };
	}
	%ret;
}}});

mutate \%state, {count \%state} for 1..6;
say eval join '+' => map { 1 } grep { $_ eq '#' }
                     map { values %$_ }
	             map { values %$_ }
	             map { values %$_ }
	             values %state;
