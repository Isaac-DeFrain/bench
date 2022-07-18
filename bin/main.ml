(* let () = Benchmark.Mono_poly.bench () *)
(*
┌───────────────────────────┬──────────┬────────────┐
│ Name                      │ Time/Run │ Percentage │
├───────────────────────────┼──────────┼────────────┤
│ Monomorphic large pattern │   7.72ns │     60.57% │
│ Monomorphic small pattern │   9.57ns │     75.07% │
│ Polymorphic large pattern │  12.74ns │    100.00% │
└───────────────────────────┴──────────┴────────────┘
*)

(* let () = Benchmark.Tail_ref.bench () *)
(*
┌───────────────────┬────────────┬─────────┬──────────┬──────────┬────────────┐
│ Name              │   Time/Run │ mWd/Run │ mjWd/Run │ Prom/Run │ Percentage │
├───────────────────┼────────────┼─────────┼──────────┼──────────┼────────────┤
│ Tail-recursion    │   939.76ns │         │          │          │     22.95% │
│ Reference         │   899.81ns │         │          │          │     21.97% │
│ Stdlib fold left  │ 1_842.85ns │         │          │          │     45.00% │
│ Stdlib fold right │ 2_270.13ns │         │          │          │     55.44% │
│ Base fold left    │ 1_862.12ns │         │          │          │     45.47% │
│ Base fold right   │ 4_094.90ns │  3.01kw │   17.32w │   17.32w │    100.00% │
└───────────────────┴────────────┴─────────┴──────────┴──────────┴────────────┘
*)
