Dependencies, compared to an unspecified unix system baseline:

* `perl (>=5.20)` for most solutions 2020
* `raku` for most solutions 2021
* `bash` (because of limitations in `GNU time` -- only needed if
   you want to do timing measurements)
* `make` (you can skip this and run the scripts directly)
* `elixir` for some variant solutions (not picked up by default)

```
make
make all
make dec04
make dec04 year=2020
```

Run only a specific problem of a day (1 or 2), with the problem
make variable, e.g. `make dec04 problem=2`. By default, it will
run both problems of the current day (in EST timezone). All the
make targets are designed for running on a single year, by
default the current year. This can be overriden using the year
variable, as can be seen in the last example above.

Enable timing by setting the time=y var, e.g. `make time=y`:

```
dec31/1: 16.009s
dec31/2: 27.010s
```

When running timing measurements, we run the solutions many times
(default 100, but override by setting the count= make variable).
This will get rid of some noise from the timings, but it does
still include some overhead from things like forking processes.
And by default, the output is "real" time which means that system
load may affect measurements. Benchmarks are best compared when
all measurements are collected from the same environment under idle
conditions. YMMV (today, it means "your measurements may vary")!
