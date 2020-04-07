class FlowRate {
  String state;
  int index;
  FlowRate({this.state, this.index});

  FlowRate.fromMap(Map data)
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

List<FlowRate> FlowRateLevels = [
  FlowRate(index: 0, state: "30"),
  FlowRate(index: 1, state: "35"),
  FlowRate(index: 2, state: "40"),
  FlowRate(index: 3, state: "45"),
  FlowRate(index: 4, state: "50"),
  FlowRate(index: 5, state: "55"),
  FlowRate(index: 6, state: "60"),
];
