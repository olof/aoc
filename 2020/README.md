### dec01
### dec02
### dec03
### dec04
#### 1

for loops are ugly. Importing `all()` from List::Util makes the
script slower for the given input size, but it would be much
prettier to use instead of the for loop in `valid()`:

```perl
all { exists $args{$_} } @mand
```
