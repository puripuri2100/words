type state = {
  mutable input_file : string option;
  mutable n : int;
  mutable is_english : bool;
}


let state = {
  input_file = None;
  n = 10;
  is_english = true;
}


let set_input_file path = state.input_file <- Some(path)
let get_input_file () = state.input_file

let set_int n = state.n <- n
let get_int () = state.n


let set_is_english b = state.is_english <- b

let get_is_english () = state.is_english