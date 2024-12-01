#!/usr/bin/python3
from aoc import *
data = list(map(str.split, stdin.readlines()))
a = Counter([int(a[0]) for a in data])
b = Counter([int(b[1]) for b in data])
print(sum([v * c * b[v] for v, c in a.items()]))
