#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
my @i = map {
	/^(?:(?<cmd>mem)\[(?P<addr>[0-9]+)\]|(?<cmd>mask))\s+=\s+(?P<arg>\S+)$/;
	({ map { $_ => $+{$_} } qw(cmd addr arg) });
} <>;

sub expand {
	my $addr = shift;
	my $bit = shift // return $addr;
	my $n = 1 << int @_;
	my $a = $addr | $n;

	return (expand($a, @_), expand($a ^ $n, @_)) if $bit eq 'X';
	return expand($bit ? $addr | $n : $addr, @_);
}

my ($mask, %mem);

{
	mem => sub {
		my ($addr, $value) = @{shift()}{qw(addr arg)};
		$mem{$_} = $value for expand($addr, split('', $mask));
	},
	mask => sub { $mask = shift->{arg} },
}->{$_->{cmd}}->($_) for @i;

say sum values %mem;
