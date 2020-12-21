#!/usr/bin/perl
use 5.020;
my (%ingredients, %possible);

for my $item (map { [[split /\s+/, $_->[0]], [split /, /, $_->[1]]] }
              map { [/^([^(]+?)\s+\(contains ([^)]+)\)$/] } <>) {
	my ($ings, $alrgs) = @$item;
	my %ings = map { ++$ingredients{$_}; $_ => 1 } @$ings;
	for my $alrg (@$alrgs) {
		$possible{$alrg} //= {%ings};
		exists $ings{$_} or delete $possible{$alrg}->{$_}
			for keys %{$possible{$alrg}};
	}
}

while (%possible) {
	my ($alrg) = grep { int keys %{$possible{$_}} == 1 } keys %possible;
	my ($ing) = keys %{delete $possible{$alrg}};
	$ingredients{$ing} = $alrg;
	delete $possible{$_}->{$ing} for keys %possible;
}

my $sum = 0;
$sum += $_ for map { int } values %ingredients;
say $sum;
