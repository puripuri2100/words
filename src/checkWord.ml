let check_ja lst ja =
  List.exists (String.equal ja) lst

let check_en w en =
  String.equal w en