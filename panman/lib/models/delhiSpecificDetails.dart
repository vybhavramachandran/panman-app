class DelhiSpecificDetails {
  bool fromMarkaz;
  String markazName;
  String district;
  String revenueDistrict;

  DelhiSpecificDetails({
    this.fromMarkaz,
    this.markazName,
    this.district,
    this.revenueDistrict,
  });

  DelhiSpecificDetails.fromMap(Map data)
      : this(
          fromMarkaz: data['fromMarkaz'],
          markazName: data['markazName'],
          district: data['district'],
          revenueDistrict: data['revenueDistrict'],
        );

  Map<String, dynamic> toMap() {
    return {
      'fromMarkaz': fromMarkaz,
      'markazName': markazName,
      'district': district,
      'revenueDistrict': revenueDistrict,
    };
  }
}
