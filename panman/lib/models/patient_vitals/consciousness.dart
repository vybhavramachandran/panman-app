class Consciousness {
  String state;
  int index;
  Consciousness({this.state, this.index});

  Consciousness.fromMap(Map data)
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

List<Consciousness> consciousnessLevels = [
  Consciousness(index: 0, state: "Alert"),
  Consciousness(index: 1, state: "Verbal"),
  Consciousness(index: 2, state: "Pain"),
  Consciousness(index: 3, state: "Unresponsive"),
];
