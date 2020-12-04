Dependencies:

* `perl (>=5.20)`
* `bash` (because of limitations in `GNU time` -- only needed if
   you want to do timing measurements)
* `make` (you can skip this and run the scripts directly)

```
make
make all
make dec04
```

Run only a specific problem of a day (1 or 2), with the problem
make variable, e.g. `make dec04 problem=2`.

Enable timing by setting the time=y var, e.g. `make time=y`:

```
dec31/1: 999
walltime: 16.009s
dec31/2: 999
walltime: 27.010s
```

Only one pass is timed so very noisy readings. YMMV (today, it
means "your measurements may vary")!
