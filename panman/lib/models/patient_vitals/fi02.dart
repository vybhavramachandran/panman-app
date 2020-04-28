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
  Fi02(index: 0, state: "Room Air"),
  Fi02(index: 1, state: "1 L"),
  Fi02(index: 2, state: "2 L"),
  Fi02(index: 3, state: "3 L"),
  Fi02(index: 4, state: "4 L"),
  Fi02(index: 5, state: "6 L"),
  Fi02(index: 6, state: "8 L"),
  Fi02(index: 7, state: "10 L"),
];
