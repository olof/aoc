#!/usr/bin/perl
use 5.020;
my @rows = map { chomp; [split //] } <>;
sub check {
	my ($r, $c, $f) = @_;
	while ($r >= 0 and $c >= 0 and $r < @rows and $c <= @{$rows[$r]}) {
		if ($rows[$r]->[$c] ne '.') {
			return $rows[$r]->[$c] eq '#';
		}
		($r, $c) = $f->($r, $c);
	}
}

sub neighbors {
	my ($row, $col) = @_;
	my $r;
	$r += $_ for map { check($_->($row, $col), $_) }
		sub { $_[0] - 1, $_[1] - 1 },
		sub { $_[0] - 1, $_[1] + 0 },
		sub { $_[0] - 1, $_[1] + 1 },
		sub { $_[0] + 1, $_[1] - 1 },
		sub { $_[0] + 1, $_[1] + 0 },
		sub { $_[0] + 1, $_[1] + 1 },
		sub { $_[0] + 0, $_[1] + 1 },
		sub { $_[0] + 0, $_[1] - 1 };
	$r
}

while (1) {
	my @changes;
	for my $row (keys @rows) {
		for my $col (keys @{$rows[$row]}) {
			my $seat = $rows[$row]->[$col];
			next if $seat eq '.';
			my $n = neighbors($row, $col);

			if ($seat eq 'L' and not $n) {
				push @changes, [$row, $col, '#', $n];
			} elsif ($seat eq '#' and $n >= 5) {
				push @changes, [$row, $col, 'L', $n]
			}
		}
	}
	last unless @changes;

	for (@changes) {
		my ($row, $col, $ch) = @$_;
		$rows[$row]->[$col] = $ch;
	}
}

say int grep { $_ eq '#' } map { @$_ } @rows;
