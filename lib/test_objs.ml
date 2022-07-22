let list =
  let rec aux acc a b = if a > b then acc else aux (b :: acc) a (b - 1) in
  aux [] 0 1000
