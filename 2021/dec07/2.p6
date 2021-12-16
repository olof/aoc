#!/usr/bin/raku

sub f($in) {
  my @in = $in.split(',').map(*.Int).sort;
  my $tf = (@in.sum / @in.elems);

  my $t1 = (@in.sum / @in.elems).floor;
  my $t2 = (@in.sum / @in.elems).ceiling;
  my $r1 = @in.map({ (1 .. abs($_ - $t1)).sum }).sum;
  my $r2 = @in.map({ (1 .. abs($_ - $t2)).sum }).sum;

  # i don't know math.
  $r1 < $r2 ?? ($t1, $r1) !! ($t2, $r2)
}

f($*IN.lines.head).tail.say

#`(

use Test;

sub t($in, ($t, $cost)) {
  my ($real_t, $real_cost) = f($in);
  is $real_t, $t, "$in should all move to $t";
  is $real_cost, $cost, "$in would cost $cost to move to $t";
}

t "1", (1, 0);
t "1,5", (3, 6);
t "1,1,5", (2, 8);
t "1,1,1,5", (2, 9);
t "1,1,1,1,1,5", (1, 10);
t "10,10,10,10,10,1", (9, 41);
t "5,5,5,5,5,5", (5, 0);
t "16,1,2,0,4,2,7,1,2,14", (5, 168);

done-testing;

)
