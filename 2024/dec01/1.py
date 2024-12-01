#!/usr/bin/python3
import sys
from itertools import starmap
sub = lambda a, b: a-b
diff = lambda a, b: abs(sub(a, b))
data = list(map(str.split, sys.stdin.readlines()))
a = sorted([int(a[0]) for a in data])
b = sorted([int(b[1]) for b in data])
print(sum(starmap(diff, zip(a, b))))
