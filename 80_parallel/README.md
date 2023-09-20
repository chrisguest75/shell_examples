# PARALLEL

Demonstrate how to use `parallel`

TODO:

* Logs and controlling running processes.
* Exit codes and summarisation.

## Install

```sh
brew install parallel

man parallel
man parallel_tutorial

# suppress the citation request.
parallel --citation

# get the number of processors parallel can see
nproc
parallel --number-of-cpus
parallel --number-of-cores
```

## Examples

```sh
# invoke commands
parallel --verbose echo {} ::: A B C

# tagging process outputs
parallel --tag echo foo-{} ::: A B C

# call an external process
parallel --tag --verbose ./workload.sh ::: A B C

# call an external process (throttle concurrency)
parallel -j 2 --tag --verbose ./workload.sh ::: A B C D E F G
parallel -j 5 --tag --verbose ./workload.sh ::: A B C D E F G
```

## Resources

* GNU Parallel 2018 (online) [here](https://zenodo.org/record/1146014)
* Youtube playlist [here](https://www.youtube.com/playlist?list=PL284C9FF2488BC6D1)
* Online version of manpage tutorial [here](https://www.gnu.org/software/parallel/parallel_tutorial.html)  