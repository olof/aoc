#!/usr/bin/python3
import sys
from collections import Counter
data = list(map(str.split, sys.stdin.readlines()))
a = Counter([int(a[0]) for a in data])
b = Counter([int(b[1]) for b in data])
print(sum([v * c * b[v] for v, c in a.items()]))
