# bench

Benchmarking differnet patterns in OCaml

## Benchmarking

To do the benchmark on your own machine, clone the repo

```bash
$ git clone https://github.com/Isaac-DeFrain/bench.git
$ cd bench
```

Install dependencies and build

```bash
$ opam install --deps-only .
$ dune build
```

To run the desired benchmarks, uncomment the appropriate line in `./bin/main.ml` and do

```bash
$ dune exec -- ./_build/default/bin/main.exe
```

## Discoveries

Here are some interesting discoveries:

- manipulating ADTs is slightly slower than manipulating the correponding GADTs
- pattern matching on ADTs is faster than the corresponding GADTs
- `Async` functions are faster then their `Stdlib` counterparts and significantly faster than their `Lwt` counterparts
- `Stdlib` functions are faster than their `Base` library counterparts
- tail-recursive list pattern matching is faster than folding over a list
- updating a mutable reference is faster than tail-recursion
