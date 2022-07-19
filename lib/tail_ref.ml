open! Base

let test_list =
  let rec aux acc a b = if a > b then acc else aux (b :: acc) a (b - 1) in
  aux [] 0 1000

(** tail-recursive pattern matching *)
module Pm = struct
  let rec add acc = function
    | [] -> acc
    | hd :: tl -> add (hd + acc) tl

  let bench () = ignore (add 0 test_list)
end

(** mutable reference *)
module Ref = struct
  let rec add l =
    let acc = ref 0 in
    match l with
    | [] -> !acc
    | hd :: tl ->
      acc := hd + !acc;
      add tl

  let bench () = ignore (add test_list)
end

(** stdlib fold_left *)
module Stdlib_fl = struct
  let add = Caml.List.fold_left ( + ) 0

  let bench () = ignore (add test_list)
end

(** stdlib fold_right *)
module Stdlib_fr = struct
  let add l = Caml.List.fold_right ( + ) l 0

  let bench () = ignore (add test_list)
end

(** base fold_left *)
module Base_fl = struct
  let add l = List.fold_left l ~init:0 ~f:( + )

  let bench () = ignore (add test_list)
end

(** base fold_right *)
module Base_fr = struct
  let add l = List.fold_right l ~init:0 ~f:( + )

  let bench () = ignore (add test_list)
end

let benchmarks =
  [ ("Tail-recursion", Pm.bench)
  ; ("Reference", Ref.bench)
  ; ("Stdlib fold left", Stdlib_fl.bench)
  ; ("Stdlib fold right", Stdlib_fr.bench)
  ; ("Base fold left", Base_fl.bench)
  ; ("Base fold right", Base_fr.bench)
  ]

let bench () =
  let open! Core_bench in
  List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
