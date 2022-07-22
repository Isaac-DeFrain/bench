open! Base

let test_list = Test_objs.list

(** tail-recursive pattern matching *)
module Pm = struct
  let rec add acc = function
    | [] -> acc
    | hd :: tl -> add (hd + acc) tl

  let bench () = ignore (add 0 test_list)

  let named_bench = ("Tail-recursion", bench)
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

  let named_bench = ("Reference", bench)
end

(** mutable reference, for loop *)
module For_ref = struct
  let len = List.length test_list

  let add l =
    let acc = ref 0 in
    for i = 0 to len - 1 do
      acc := !acc + List.nth_exn l i
    done

  let bench () = ignore (add test_list)

  let named_bench = ("Ref for-loop", bench)
end

(** stdlib fold_left *)
module Stdlib_fl = struct
  let add = Caml.List.fold_left ( + ) 0

  let bench () = ignore (add test_list)

  let named_bench = ("Stdlib fold left", bench)
end

(** stdlib fold_right *)
module Stdlib_fr = struct
  let add l = Caml.List.fold_right ( + ) l 0

  let bench () = ignore (add test_list)

  let named_bench = ("Stdlib fold right", bench)
end

(** base fold_left *)
module Base_fl = struct
  let add l = List.fold_left l ~init:0 ~f:( + )

  let bench () = ignore (add test_list)

  let named_bench = ("Base fold left", bench)
end

(** base fold_right *)
module Base_fr = struct
  let add l = List.fold_right l ~init:0 ~f:( + )

  let bench () = ignore (add test_list)

  let named_bench = ("Base fold right", bench)
end

let benchmarks =
  [ Pm.named_bench
  ; Ref.named_bench
  ; Stdlib_fl.named_bench
  ; Stdlib_fr.named_bench
  ; Base_fl.named_bench
  ; Base_fr.named_bench
  ]

let bench () =
  let open! Core_bench in
  List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
