class OxygenDelivery {
  String state;
  int index;
  OxygenDelivery({this.state, this.index});

  OxygenDelivery.fromMap(Map data)
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

List<OxygenDelivery> OxygenDeliveryTypes = [
  OxygenDelivery(index: 0, state: "Nasal Prongs"),
  OxygenDelivery(index: 1, state: "Face Mask"),
  OxygenDelivery(index: 2, state: "Venturi Mask"),
  OxygenDelivery(index: 3, state: "NRBM"),
];
