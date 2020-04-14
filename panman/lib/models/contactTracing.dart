class contactTracing {
  String sourceOfInfection;
  bool isMorePatientInfoAvailable;
  String sourcePatientFirstName;
  String sourcePatientLastName;
  String sourcePatientAddress;
  String sourcePatientNumber;

  contactTracing(
      {this.sourceOfInfection,
      this.isMorePatientInfoAvailable,
      this.sourcePatientFirstName,
      this.sourcePatientLastName,
      this.sourcePatientAddress,
      this.sourcePatientNumber});

  contactTracing.fromMap(Map data)
      : this(
        
          sourceOfInfection: data['sourceOfInfection'],
          isMorePatientInfoAvailable: data['isMorePatientInfoAvailable'],
          sourcePatientFirstName: data['sourcePatientFirstName'],
          sourcePatientLastName: data['sourcePatientLastName'],
        );

  Map<String, dynamic> toMap() {
    return {
      'sourceOfInfection': sourceOfInfection,
      'isMorePatientInfoAvailable': isMorePatientInfoAvailable,
      'sourcePatientFirstName': sourcePatientFirstName,
      'sourcePatientLastName': sourcePatientLastName,
    };
  }
}
