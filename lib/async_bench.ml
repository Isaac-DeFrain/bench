open! Async

let test_list = Test_objs.list

(** async list fold *)
module Async_list_fold = struct
  let add l = Deferred.List.fold l ~init:0 ~f:(fun acc x -> acc + x |> return)

  let bench () = add test_list >>> fun _ -> Shutdown.shutdown 0

  let named_bench = ("Async list fold", bench)
end

(** async list foldi *)
module Async_list_foldi = struct
  let add l =
    Deferred.List.foldi l ~init:0 ~f:(fun _ acc x -> acc + x |> return)

  let bench () = add test_list >>> fun _ -> Shutdown.shutdown 0

  let named_bench = ("Async list foldi", bench)
end

(** async list iter *)
module Async_list_iter = struct
  let add l =
    let acc = ref 0 in
    Deferred.List.iter l ~f:(fun x -> return (acc := !acc + x))

  let bench () = add test_list >>> fun _ -> Shutdown.shutdown 0

  let named_bench = ("Async list iter", bench)
end

(** async list iteri *)
module Async_list_iteri = struct
  let add l =
    let acc = ref 0 in
    Deferred.List.iteri l ~f:(fun _ x -> return (acc := !acc + x))

  let bench () = add test_list >>> fun _ -> Shutdown.shutdown 0

  let named_bench = ("Async list iteri", bench)
end

let benchmarks = [ Async_list_fold.named_bench ]
(* [ Async_list_foldi.named_bench; ] *)
(* [ Async_list_iter.named_bench; ] *)
(* [ Async_list_iteri.named_bench ] *)

let bench () =
  let open! Core_bench in
  Base.List.map benchmarks ~f:(fun (name, test) -> Bench.Test.create ~name test)
  |> Bench.make_command |> Command_unix.run
