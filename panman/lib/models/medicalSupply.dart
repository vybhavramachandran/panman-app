class medicalSupply {
  String id;

  int qty;

  medicalSupply({this.id, this.qty});

  medicalSupply.fromMap(Map data)
      : this(
          id: data['id'],
          qty: data['qty'],
        );

  
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'qty':qty,
    };
  }
}
