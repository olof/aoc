#!/usr/bin/perl
use 5.020;
use List::Util qw(uniq min max);

sub perm {
	my $p = shift;
	my $n = shift;
	return () unless @_;
	perm(@_), map {
		my ($x1, $x2) = ($n % $mod, $_ % $mod);
		my $xdiff = max($x1, $x2) - min($x1, $x2);
		my $diff = $_ - $n;
		my $out_l = sub { pop() + $xdiff < $mod };
		my $out_r = sub { pop() - $xdiff >= 0 };
		$x1 < $x2 ? ($out_r->($x1) ? ($n - $diff) : (),
		             $out_l->($x2) ? ($_ + $diff) : ())
			  : ($out_l->($x1) ? ($n - $diff) : (),
		             $out_r->($x2) ? ($_ + $diff) : ())
	} @_;
}

my @input = map { /(\S)/g } <>;
my $period = @input / $.;
my %group;

for my $i (keys @input) {
	my $input = $input[$i];
	next if $input eq '.';
	$group{$input} //= [];
	push @{$group{$input}}, $i;
}

say int uniq grep { $_ >= 0 and $_ < @input }
                  map { perm($period, @$_) }
	          values %group
