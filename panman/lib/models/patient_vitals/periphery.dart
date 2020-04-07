class Periphery {
  String state;
  int index;
  Periphery({this.state, this.index});

  Periphery.fromMap(Map data)
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

List<Periphery> PeripheryLevels = [
  Periphery(index: 0, state: "Cold"),
  Periphery(index: 1, state: "Tepid"),
  Periphery(index: 2, state: "Warm"),
  Periphery(index: 3, state: "Hot"),
];
