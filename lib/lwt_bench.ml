open! Lwt

let test_list = Test_objs.list

(** lwt fold_left_s *)
module Lwt_fold_left = struct
  let add l = Lwt_list.fold_left_s (fun acc x -> acc + x |> return) 0 l

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt fold left", bench)
end

(** lwt fold_right_s *)
module Lwt_fold_right = struct
  let add l = Lwt_list.fold_right_s (fun acc x -> acc + x |> return) l 0

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt fold right", bench)
end

(** lwt iter_p *)
module Lwt_iter_p = struct
  let add l =
    let acc = ref 0 in
    Lwt_list.iter_p (fun x -> return (acc := !acc + x)) l

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt iter p", bench)
end

(** lwt iteri_p *)
module Lwt_iteri_p = struct
  let add l =
    let acc = ref 0 in
    Lwt_list.iteri_p (fun _ x -> return (acc := !acc + x)) l

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt iteri p", bench)
end

(** lwt iter_s *)
module Lwt_iter_s = struct
  let add l =
    let acc = ref 0 in
    Lwt_list.iter_s (fun x -> return (acc := !acc + x)) l

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt iter s", bench)
end

(** lwt iteri_s *)
module Lwt_iteri_s = struct
  let add l =
    let acc = ref 0 in
    Lwt_list.iteri_s (fun _ x -> return (acc := !acc + x)) l

  let bench () = on_success (add test_list) ignore

  let named_bench = ("Lwt iteri s", bench)
end

let benchmarks =
  [ Lwt_fold_left.named_bench
  ; Lwt_fold_right.named_bench
  ; Lwt_iter_p.named_bench
  ; Lwt_iteri_p.named_bench
  ; Lwt_iter_s.named_bench
  ; Lwt_iteri_s.named_bench
  ]

let bench () =
  let open! Core_bench in
  Base.List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
