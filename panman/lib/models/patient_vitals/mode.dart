class Mode {
  String state;
  int index;
  Mode({this.state, this.index});

  Mode.fromMap(Map data)
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

List<Mode> ModeLevels = [
  Mode(index: 0, state: "ASV"),
  Mode(index: 1, state: "SIMV VC"),
  Mode(index: 2, state: "SIMV PC"),
  Mode(index: 3, state: "AC PRVC/ PRVC VG"),
  Mode(index: 4, state: "PSV/ PS-CPAP"),
  Mode(index: 5, state: "T Piece"),
];
