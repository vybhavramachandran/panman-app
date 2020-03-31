class equipment {
  String id;
  int qty;
  String icon;

  equipment({this.id, this.qty, this.icon});
   equipment.fromMap(Map data)
      : this(
          id: data['equipmentID'],
          qty: data['qty'],
        );

  Map<String, dynamic> toMap() {
    return {
      'equipmentID':id,
      'qty':qty,
    };
  }
}
