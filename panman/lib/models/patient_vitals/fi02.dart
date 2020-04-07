class Fi02 {
  String state;
  int index;
  Fi02({this.state, this.index});

  Fi02.fromMap(Map data)
      : this(
          state: data['state'],
          index: data['index'],
        );

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'index': index,
    };
  }
}

List<Fi02> Fi02Levels = [
  Fi02(index: 0, state: "21 Room Air"),
  Fi02(index: 1, state: "24 - 1 L nasal"),
  Fi02(index: 2, state: "28 - 2 L nasal"),
  Fi02(index: 3, state: "32 - 3 L nasal"),
  Fi02(index: 4, state: "36 - 4 L nasal"),
  Fi02(index: 5, state: "40 - 6 L FM"),
  Fi02(index: 6, state: "50 - 8 L FM"),
  Fi02(index: 7, state: "60 - 10 L FM"),
];
