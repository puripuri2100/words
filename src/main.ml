open Arg
open Csv

open OptionState
open WordList
open CheckWord
open PrintWord


let option_from x opt =
  match opt with
  | Some(a) -> a
  | None -> x


let rec take i lst =
  match lst with
  | []      -> []
  | x :: xs -> (
      if i < 0 then
        []
      else
        x :: (take (i - 1) xs)
  )


let rec drop i lst =
  if i < 0 then
    lst
  else
    match lst with
    | []      -> []
    | x :: xs -> (
        if i < 1 then
          xs
        else
          drop (i - 1) xs
    )

let rec main_word_en csv_data loop =
  if loop <= 0 then
    ()
  else
    let () = Random.init loop in
    let n = (Random.int loop) mod (List.length csv_data) + 1  in
    let data = WordList.get_data csv_data n in
    let en_str = WordList.get_en data in
    let () = PrintWord.print_ja data in
    let en = read_line () in
    let b = CheckWord.check_en en_str en in
    let () = PrintWord.judg_en b en_str in
    main_word_en csv_data (loop - 1)


let rec main_word_ja csv_data loop =
  if loop <= 0 then
    ()
  else
    let () = Random.init loop in
    let n = (Random.int loop) mod (List.length csv_data) + 1  in
    let data = WordList.get_data csv_data n in
    let ja_lst = WordList.get_ja data in
    let () = PrintWord.print_en data in
    let ja = read_line () in
    let b = CheckWord.check_ja ja_lst ja in
    let () = PrintWord.judg_ja b ja_lst in
    main_word_ja csv_data (loop - 1)



let get_csv_data path =
  Csv.load path


let arg_version () =
  print_string "words version 0.0.1\n"


let arg_input_file curdir s =
  let path =
    if Filename.is_relative s then
      Filename.concat curdir s
    else
      s
  in
  OptionState.set_input_file path

let arg_int n =
  OptionState.set_int n


let arg_japanese () =
  OptionState.set_is_english false


let arg_english () =
  OptionState.set_is_english true


let arg_start n =
  OptionState.set_start n

let arg_end n =
  OptionState.set_end n



let arg_spec curdir =
  [
    ("-v",        Arg.Unit(arg_version)  , "Prints version");
    ("--version", Arg.Unit(arg_version)  , "Prints version");
    ("-f",     Arg.String (arg_input_file curdir), "Specify CSV file");
    ("-n",     Arg.Int (arg_int), "Number of times");
    ("--start",Arg.Int (arg_start), "Number of start");
    ("--end",  Arg.Int (arg_end), "Number of end");
    ("--ja", Arg.Unit(arg_japanese), "Japanese");
    ("--en", Arg.Unit(arg_english), "English");
  ]


let main =
  let curdir = Sys.getcwd () in
  let () = Arg.parse (arg_spec curdir) (arg_input_file curdir) "" in
  let raw_csv_data = OptionState.get_input_file () |> option_from "" |> get_csv_data in
  let start_num = OptionState.get_start () |> option_from 1 |> (fun n -> n - 1) in
  let end_num = OptionState.get_end () |> option_from (List.length raw_csv_data) |> (fun n -> n - 1) in
  let csv_data = raw_csv_data |> take end_num |> drop start_num in
  let n = OptionState.get_int () in
  let () =
    if OptionState.get_is_english () then
      main_word_en csv_data n
    else
      main_word_ja csv_data n
  in
  ()
