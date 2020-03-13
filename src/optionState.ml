type state = {
  mutable input_file : string option;
  mutable n : int;
  mutable is_english : bool;
  mutable start_num : int option;
  mutable end_num : int option;
}


let state = {
  input_file = None;
  n = 10;
  is_english = true;
  start_num = None;
  end_num = None;
}


let set_input_file path = state.input_file <- Some(path)
let get_input_file () = state.input_file

let set_int n = state.n <- n
let get_int () = state.n


let set_is_english b = state.is_english <- b
let get_is_english () = state.is_english

let set_start n = state.start_num <- Some(n)
let get_start () = state.start_num

let set_end n = state.end_num <- Some(n)
let get_end () = state.end_num
