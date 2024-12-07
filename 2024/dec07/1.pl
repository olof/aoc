#!/usr/bin/perl
use 5.020;
use List::Util qw(sum any);

sub expand {
	my $base = shift;
	return $base if not @_;
	my $n = shift @_;
	map { expand("($base $_ $n)", @_) } qw(+ *);;
}

$, = " ";

say sum
 map { $_->[0] }
 grep { $_->[1] }
 map { my $t = shift @$_; [$t, any { $t == eval($_) } @$_] }
 map { my $t = shift @$_; [$t, expand(@$_)] }
 map { [/\b([0-9]+)\b/g] }
 <>;
