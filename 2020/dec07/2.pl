#!/usr/bin/perl
use 5.020;
my %rules = map {
	my ($k, $rule) = /^(.+?) bags? contain (no other bags|.+)\.$/;
	$rule = '0 other bags' if $rule eq 'no other bags';
	$k => { map { reverse /^([0-9]+) (.+?) bags?$/ } split /, /, $rule }
} <>;

sub count {
	my $color = shift;
	my $res = 1;
	for (sort keys %{$rules{$color}}) {
		$res += (count($_) * $rules{$color}->{$_})
	}
	$res;
}

say count('shiny gold') - 1;
