open! Base
open! Core_bench

module Monomorphic = struct
  type t =
    | Alice
    | Bob
    | Charlie
    | David

  let bench () =
    let convert = function
      | Alice -> 100
      | Bob -> 101
      | Charlie -> 102
      | David -> 103
    in
    List.iter ~f:(fun v -> ignore (convert v)) [ Alice; Bob; Charlie; David ]
end

module Monomorphic_small = struct
  type t =
    | Alice
    | Bob

  let bench () =
    let convert = function
      | Alice -> 100
      | Bob -> 101
    in
    List.iter ~f:(fun v -> ignore (convert v)) [ Alice; Bob; Alice; Bob ]
end

module Polymorphic = struct
  type t =
    [ `Alice
    | `Bob
    | `Charlie
    | `David
    ]

  let bench () =
    let convert = function
      | `Alice -> 100
      | `Bob -> 101
      | `Charlie -> 102
      | `David -> 103
    in
    List.iter
      ~f:(fun v -> ignore (convert v))
      [ `Alice; `Bob; `Charlie; `David ]
end

let benchmarks =
  [ ("Monomorphic large pattern", Monomorphic.bench)
  ; ("Monomorphic small pattern", Monomorphic_small.bench)
  ; ("Polymorphic large pattern", Polymorphic.bench)
  ]

let bench () =
  List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
