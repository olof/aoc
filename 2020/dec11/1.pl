#!/usr/bin/perl
use 5.020;
my @rows = map { chomp; [split //] } <>;
sub neighbors {
	my ($row, $col) = @_;
	int grep { $_ eq '#' }
		$rows[$row+1]->[$col+1],
		$rows[$row+1]->[$col],
		$rows[$row+1]->[$col-1],
		$rows[$row]->[$col+1],
		$rows[$row]->[$col-1],
		$rows[$row-1]->[$col+1],
		$rows[$row-1]->[$col],
		$rows[$row-1]->[$col-1],
}

while (1) {
	my @changes;
	for my $row (keys @rows) {
		for my $col (keys @{$rows[$row]}) {
			my $seat = $rows[$row]->[$col];
			next if $seat eq '.';
			my $n = neighbors($row, $col);

			if ($seat eq 'L' and not $n) {
				push @changes, [$row, $col, '#'];
			} elsif ($seat eq '#' and $n >= 4) {
				push @changes, [$row, $col, 'L']
			}
		}
	}
	last unless @changes;
	$rows[$_->[0]]->[$_->[1]] = $_->[2] for @changes;
}

say int grep { $_ eq '#' } map { @$_ } @rows;
