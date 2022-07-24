(lang dune 3.3)

(name bench)

(generate_opam_files true)

(source
 (github Isaac-DeFrain/bench))

(authors "Isaac DeFrain")

(maintainers "Isaac DeFrain")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name bench)
 (synopsis "Benchmarking patterns in OCaml")
 (description "A longer description")
 (depends ocaml dune async base core_bench core_unix)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

