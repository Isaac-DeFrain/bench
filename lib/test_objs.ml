open! Base

let list =
  let rec aux acc a b = if a > b then acc else aux (b :: acc) a (b - 1) in
  aux [] 0 1000

let char_list =
  let rec aux acc n =
    if n > 0 then aux (Random.char () :: acc) (n - 1) else acc
  in
  aux [] 1000

let bool_list =
  let rec aux acc n =
    if n > 0 then aux (Random.bool () :: acc) (n - 1) else acc
  in
  aux [] 1000
