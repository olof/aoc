### dec04
#### 1

for loops are ugly. Importing `all()` from List::Util makes the
script slower for the given input size, but it would be much
prettier to use instead of the for loop in `valid()`:

```perl
all { exists $args{$_} } @mand
```

### dec05

My solution treats the string as a binary digit string. But in my
first published revision, I made the mistake of thinking I had to
differentiate the lower bits from the higher bits (rows from
columns), but there are only three column bits representing eight
columns, so I basically did `($row >> 3) * 8 + $col`, which is
the same as `$row + $col`, which is the same as not touching it
at all.

This was made painfully obvious to me by looking at the similar
solution from [@abigail][abigail/dec05/gh] (and accompanying
[blog post][abigail/dec05/wp]). I don't think I'll normally be in
the habit of adjusting my solutions after studying other people's
solution, but this was just unnecessary work, and I can't stand
for it! But let the record (and git log) show that I can't reason
about integer multiplication :).

[abigail/dec05/gh]: https://github.com/Abigail/AdventOfCode2020/blob/master/Day_05/solution.pl
[abigail/dec05/wp]: https://programmingblog702692439.wordpress.com/2020/12/05/advent-of-code-2020-day-5/

### dec15

The two subproblems of dec15 are the same, the only difference
being the iteration count (problem 2 is much higher). Iterating
my solution 2020 (problem 1) times is no biggie (~0.01s including
perl process initialization), but running it 30000000 (problem 2)
takes over 15s on my machine. Unhappy about that, but I guess I
should be glad I solved it at all unlike `dec13/2`.
