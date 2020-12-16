#!/usr/bin/perl
use 5.020;
use List::Util qw(product);
$/ = "\n\n";

my %rules = map { my ($k, @v) = @$_;
	          $k => sub { $_[0] >= $v[0] and $_[0] <= $v[1] or
		              $_[0] >= $v[2] and $_[0] <= $v[3] }
} map { [/([^:]+):\s*([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$/] } split /\n/, <>;
my @my = map { split /,/ } <> =~ /^your ticket:\n(.*)\n*$/;

sub check { my $n = shift; grep { not $rules{$_}->($n) } keys %rules }
sub valid { int check($_) == keys %rules and return 0 for @_; 1 }
my @valid = grep { valid(@$_) } map { [split/,/] } map { split/\n/ }
	    <> =~ /^nearby tickets:\n(.*)\n*$/s;

my %valids = map { $_ => { map { $_ => 1 } keys %rules } } 0..$#my;
for my $t (@valid) {
	for my $i (0..$#$t) {
		delete $valids{$i}->{$_} for check($t->[$i])
	}
}

my %unknown = map { $_ => 1 } keys %rules;
my %known;

while (%unknown) {
	for my $i (keys %valids) {
		my ($rule, @r) = keys %{$valids{$i}};
		next if not $rule or @r;
		$known{$rule} = $i;
		delete $unknown{$rule};
		delete $valids{$_}->{$rule} for 0..$#my;
	}
}

say product map { $my[$known{$_}] } grep { /^departure / } keys %known;
