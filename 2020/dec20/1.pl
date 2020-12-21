#!/usr/bin/perl
use 5.020;
$/="\n\n";
my %tiles;

sub rev { scalar reverse split //, shift }

for (<>) {
	my ($id, $tile) = /^Tile (\d+):\n(.*)/s;
	my @tile = split /\n/, $tile;

	my ($b1, $b2) = ($tile[0], $tile[$#tile]);
	my $b3 = join '', map { substr $_, 0, 1 } @tile;
	my $b4 = join '', map { substr $_, -1 } @tile;

	for my $cfg ([$b1, $b2, $b3, $b4],
	             [rev($b1), rev($b2), $b4, $b3],
	             [$b2, $b1, rev($b4), rev($b3)],
	             [rev($b2), rev($b1), rev($b4), rev($b3)]) {
		for (@$cfg) {
			push @$cfg, shift @$cfg;
			$tiles{$cfg->[$_]}->{$id} = 1 for 0..$#$cfg;
		}
	}
}

# consider only tiles that got unique edges
my %edges;
++$edges{$_} for map { keys %{$tiles{$_}} }
                 grep { keys %{$tiles{$_}} == 1 }
                 keys %tiles;

# product of all the tiles with enough unique edges to be a
# corner, with transformations considered (four).
my $res = 1;
$res *= $_ for grep { $edges{$_} == 4 }
               keys %edges;
say $res;
