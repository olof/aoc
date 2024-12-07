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

sub arrange {
	my $deps = shift;
	my %nums = map { $_ => 1 } @_;
	my @res;
	my %defer;

	my $undeps = sub { my %x = @_; grep { not %{$x{$_}//{}} } keys %x };

	for (reverse @_) {
		my @undeps;
		$defer{$_} = { map { $_ => 1 }
		               grep { $nums{$_} }
		               keys %{$deps->{$_} // {}} };

		do {
			@undeps = $undeps->(%defer);
			for my $d (@undeps) {
				unshift @res, $d;
				delete $defer{$d};
				delete $nums{$d};
				for my $x (keys %defer) {
					delete $defer{$x}->{$d};
				}
			}
		} while (@undeps);
	}

	@res
}

my ($deps, $updates) = parse;
say sum map { $_->[$#$_/2] }
        map { [arrange($deps, @$_)] }
        grep { not check($deps, @$_) }
        @$updates;
