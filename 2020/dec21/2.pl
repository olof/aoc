#!/usr/bin/perl
use 5.020;
my (%ingredients, %possible);

for my $item (map { [[split /\s+/, $_->[0]], [split /, /, $_->[1]]] }
              map { [/^([^(]+?)\s+\(contains ([^)]+)\)$/] } <>) {
	my ($ings, $alrgs) = @$item;
	my %ings = map { ++$ingredients{$_}; $_ => 1 } @$ings;
	for my $alrg (@$alrgs) {
		$possible{$alrg} //= {%ings};
		for (keys %{$possible{$alrg}}) {
			next if exists $ings{$_};
			delete $possible{$alrg}->{$_};
		}
	}
}

while (%possible) {
	my ($alrg) = grep { int keys %{$possible{$_}} == 1 } keys %possible;
	my ($ing) = keys %{delete $possible{$alrg}};
	$ingredients{$ing} = $alrg;
	delete $possible{$_}->{$ing} for keys %possible;
}

say join ',' => sort { $ingredients{$a} cmp $ingredients{$b} }
                grep { not int $ingredients{$_} }
		keys %ingredients;
