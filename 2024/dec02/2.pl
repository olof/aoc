#!/usr/bin/perl
use 5.020;
sub f {
	my ($cand, $ok, $extra) = @_;
	my @cand = @$cand;
	my @ok = @$ok;

	return @ok if not @cand;
	my $this = shift @cand;
	my $last = $ok[$#ok];

	my @res = (!@ok or
	           $last != $this and
		   abs $last - $this < 4 and
		   @ok < 2 || (($ok[$#ok] <=> $this) == ($ok[0] <=> $ok[1])))
	? f(\@cand, [@ok, $this], $extra)
	: $extra ? f(\@cand, \@ok, 0) : ();
	(@res or not $extra) ? @res : f(\@cand, \@ok, 0)
}

say int grep { f($_, [], 1) } map { [map { int } split] } <>;
