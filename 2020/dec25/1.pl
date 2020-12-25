#!/usr/bin/perl
use 5.020;
my $pub = { map { $_ => int <> } qw(card door) };

sub loopsize {
	my $subject = shift;

	my %unknown = reverse @_;
	my ($i, $v, $ret) = (0, 1, {});

	while (%unknown and ++$i) {
		$v = ($v * $subject) % 20201227;
		$ret->{delete $unknown{$v}} = $i if $unknown{$v};
	}

	$ret
}

sub decrypt {
	my ($subject, $loopsize) = @_;
	my $v = 1;
	$v = ($v * $subject) % 20201227 for 1..$loopsize;
	$v
}

my $loop = loopsize(7, map { $_ => $pub->{$_} } qw(card door));
say decrypt($pub->{door}, $loop->{card});
