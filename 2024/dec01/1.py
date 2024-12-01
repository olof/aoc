#!/usr/bin/python3
from aoc import *
sub = lambda a, b: a-b
diff = lambda a, b: abs(sub(a, b))
data = list(map(str.split, stdin.readlines()))
a = sorted([int(a[0]) for a in data])
b = sorted([int(b[1]) for b in data])
print(sum(starmap(diff, zip(a, b))))
