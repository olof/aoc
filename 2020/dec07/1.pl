#!/usr/bin/perl
use 5.020;
my %rules = map {
	my ($k, $rule) = /^(.+?) bags? contain (no other bags|.+)\.$/;
	$rule = '0 other bags' if $rule eq 'no other bags';
	$k => { map { reverse /^([0-9]+) (.+?) bags?$/ } split /, /, $rule }
} <>;
my %reverse;
for my $color (keys %rules) {
	for (keys %{$rules{$color}}) {
		$reverse{$_}->{$color} = $reverse{$color} //= {};
	}
}
sub walk {
	my $x = shift;
	map { $_ => 1, defined $x->{$_} ? walk($x->{$_}) : () } keys %$x;
}
my %res = walk($reverse{'shiny gold'});
say int keys %res;
