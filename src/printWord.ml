open WordList
open CheckWord


let join s1 s2 = s1 ^ " " ^ s2

let print_ja data =
  let ja_lst = WordList.get_ja data in
  let ja_str =
    ja_lst
    |> List.map (fun s -> "\"" ^ s ^ "\"")
    |> List.fold_left join ""
  in
  Printf.printf "Japanese : %s\n" ja_str


let print_en data =
  let en_str = WordList.get_en data in
  Printf.printf "English : %s\n" en_str


let judg_en b w =
  if b then
    Printf.printf "%s\n" "Congratulations!"
  else
    Printf.printf "%s%s\n" "The answer is " w


let judg_ja b lst =
  let s =
    lst
    |> List.map (fun s -> "\"" ^ s ^ "\"")
    |> List.fold_left join ""
  in
  if b then
    Printf.printf "%s\n" "Congratulations!"
  else
    Printf.printf "%s%s\n" "The answer is " s