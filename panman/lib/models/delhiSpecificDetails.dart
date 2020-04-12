class DelhiSpecificDetails {
  bool fromMarkaz;
  String markazName;
  String district;
  String revenueDistrict;
  bool isResidentOfDelhi;
  bool isHealthCareWorker;
  String fatherOrHusbandFirstName;
  String fatherOrHusbandLastName;

  DelhiSpecificDetails({
    this.fromMarkaz,
    this.markazName,
    this.district,
    this.revenueDistrict,
    this.fatherOrHusbandFirstName,
    this.fatherOrHusbandLastName,
    this.isResidentOfDelhi,
    this.isHealthCareWorker,
  });

  DelhiSpecificDetails.fromMap(Map data)
      : this(
          fromMarkaz: data['fromMarkaz'],
          markazName: data['markazName'],
          district: data['district'],
          revenueDistrict: data['revenueDistrict'],
          fatherOrHusbandFirstName: data['fatherOrHusbandFirstName'],
          fatherOrHusbandLastName: data['fatherOrHusbandLastName'],
          isResidentOfDelhi: data['isResidentOfDelhi'],
          isHealthCareWorker: data['isHealthCareWorker'],
        );

  Map<String, dynamic> toMap() {
    return {
      'fromMarkaz': fromMarkaz != null ? fromMarkaz : "",
      'markazName': markazName != null ? markazName : "",
      'district': district != null ? district : "",
      'fatherOrHusbandFirstName':
          fatherOrHusbandFirstName != null ? fatherOrHusbandFirstName : "",
      'fatherOrHusbandLastName':
          fatherOrHusbandLastName != null ? fatherOrHusbandLastName : "",
      'isResidentOfDelhi': isResidentOfDelhi,
      'isHealthCareWorker': isHealthCareWorker,
      'revenueDistrict': revenueDistrict != null ? revenueDistrict : "",
    };
  }
}
