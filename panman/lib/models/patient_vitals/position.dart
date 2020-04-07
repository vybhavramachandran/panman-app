class Position {
  String state;
  int index;
  Position({this.state, this.index});

  Position.fromMap(Map data)
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

List<Position> PositionLevels = [
  Position(index: 0, state: "Self Positioning"),
  Position(index: 1, state: "Supine, Head Up"),
  Position(index: 2, state: "Supine Flat"),
  Position(index: 3, state: "Right Lateral"),
  Position(index: 4, state: "Left Lateral"),
  Position(index: 5, state: "Right Recovery"),
  Position(index: 6, state: "Left Recovery"),
  Position(index: 7, state: "Prone"),
  Position(index: 8, state: "Chair/ Sofa"),
];
