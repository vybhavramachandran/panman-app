class Rhythm {
  String state;
  int index;
  Rhythm({this.state, this.index});

  Rhythm.fromMap(Map data)
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

List<Rhythm> RhythmLevels = [
  Rhythm(index: 0, state: "Sinus"),
  Rhythm(index: 1, state: "AF"),
  Rhythm(index: 2, state: "Atrial Flutter"),
  Rhythm(index: 3, state: "VT"),
  Rhythm(index: 4, state: "VF"),
  Rhythm(index: 5, state: "Junctional Rhythm"),
];
