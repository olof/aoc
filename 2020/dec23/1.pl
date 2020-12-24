#!/usr/bin/perl
use 5.020;
my @input = grep { int } split //, <>;
my $len = int @input;
my ($high) = sort { $b<=>$a } @input;

my $cur = 0;
for (1..100) {
	my $v = $input[$cur];
	my $wrap = $cur + 3 >= $len ? ($cur - $len + 4) % $len : 0;
	my @cups = (splice(@input, $cur+1, 3), splice(@input, 0, $wrap));

	my ($w) = sort { $input[$b] <=> $input[$a] }
	          grep { $input[$_] < $v }
		  0..$#input;
	   ($w) = sort { $input[$b] <=> $input[$a] }
	          grep { $input[$_] <= $high }
		  0..$#input unless defined $w;
	splice @input, ($w + 1) % @input, 0, @cups;

	my ($cur_idx) = grep { $v == $input[$_] } 0..$#input;
	$cur = ($cur_idx + 1) % @input;
}

say join("", @input) =~ s/(.*)1(.*)/\2\1/r;
