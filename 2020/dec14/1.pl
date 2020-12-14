#!/usr/bin/perl
use 5.020;
my @i = map {
	/^(?:(?<cmd>mem)\[(?P<addr>[0-9]+)\]|(?<cmd>mask))\s+=\s+(?P<arg>\S+)$/;
	({ map { $_ => $+{$_} } qw(cmd addr arg) });
} <>;

my ($m1, $m2, %mem);
{
	mem => sub { $mem{$_->{addr}} = ($_->{arg} | $m1) & $m2 },
	mask => sub {
		local $_ = $_->{arg};
		$m1 = eval "0b" . s/X/0/gr;
		$m2 = eval "0b" . s/[X1]/1/gr;
	},
}->{$_->{cmd}}->($_) for @i;

my $sum = 0;
$sum += $_ for values %mem;
say $sum;
