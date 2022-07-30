open! Base
open! Core_bench

let test_list = Test_objs.list

(* manipulating an ADT *)
module Adt = struct
  type t =
    | Int of int
    | Fun of (int -> int -> int)
    | App of t * t * t

  let rec add acc = function
    | [] -> acc
    | hd :: tl ->
      let app = function
        | App (Fun f, Int x, Int y) -> Int (f x y)
        | _ -> failwith "only add Adt.Int"
      in
      add (app @@ App (Fun ( + ), acc, hd)) tl

  let bench () = ignore @@ add (Int 0) @@ List.map test_list ~f:(fun x -> Int x)

  let named_bench = ("Adt", bench)
end

(* manipulating a GADT *)
module Gadt = struct
  type _ t =
    | Int : int -> int t
    | Fun : (int -> int -> int) -> (int -> int -> int) t
    | App : ('a -> 'a -> 'a) t * 'a t * 'a t -> 'a t

  let rec add acc = function
    | [] -> acc
    | hd :: tl ->
      let app = function
        | App (Fun f, Int x, Int y) -> Int (f x y)
        | _ -> failwith "only add Gadt.Int"
      in
      add (app @@ App (Fun ( + ), acc, hd)) tl

  let bench () = ignore @@ add (Int 0) @@ List.map test_list ~f:(fun x -> Int x)

  let named_bench = ("Gadt", bench)
end

(* ADT pattern matching *)
module Adt_pm = struct
  type t =
    | A of int
    | B of bool
    | C of char

  let default_int = 0

  let default_char = 'a'

  let test_list =
    let open Test_objs in
    let ints = List.map list ~f:(fun x -> A x) in
    let bools = List.map bool_list ~f:(fun x -> B x) in
    let chars = List.map char_list ~f:(fun x -> C x) in
    ints @ bools @ chars

  let destruct_and_check = function
    | A x -> Int.( = ) x default_int
    | B b -> b
    | C c -> Char.( = ) c default_char

  let bench () = ignore @@ List.map test_list ~f:destruct_and_check

  let named_bench = ("Adt_pm", bench)
end

(* GADT pattern matching *)
module Gadt_pm = struct
  type _ t =
    | A : int -> int t
    | B : bool -> int t
    | C : char -> int t

  let test_list =
    let open Test_objs in
    let ints = List.map list ~f:(fun x -> A x) in
    let bools = List.map bool_list ~f:(fun x -> B x) in
    let chars = List.map char_list ~f:(fun x -> C x) in
    ints @ bools @ chars

  let destruct_and_check = function
    | A x -> Int.( = ) x 0
    | B b -> b
    | C c -> Char.( = ) c 'a'

  let bench () = ignore @@ List.map test_list ~f:destruct_and_check

  let named_bench = ("Gadt_pm", bench)
end

let benchmarks =
  [ Adt.named_bench; Gadt.named_bench; Adt_pm.named_bench; Gadt_pm.named_bench ]

let bench () =
  let open! Core_bench in
  Base.List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
