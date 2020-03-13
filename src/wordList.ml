let get_data lst n =
  List.nth lst (n - 1)

let get_ja lst =
  List.tl lst

let get_en lst =
  List.hd lst