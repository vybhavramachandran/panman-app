import '../models/locationInHospital.dart';

import './address.dart';
import './equipment.dart';
import './medicalSupply.dart';

class Hospital {
  String id;
  String govtID;
  String hospitalName;
  FullAddress fullAddress;
  List<equipment> equipments;
  List<locationInHospital> locations;
  List<medicalSupply> medicalSupplies;

  Hospital(
      {this.id,
      this.govtID,
      this.hospitalName,
      this.fullAddress,
      this.equipments,
      this.locations,
      this.medicalSupplies});

  Hospital.fromMap(Map data)
      : this(
          id: data['id'],
          govtID: data['govtID'],
          hospitalName: data['hospitalName'],
          fullAddress: FullAddress.fromMap(data['fullAddress']),
          equipments: data['equipments'].map<equipment>((item) {
            return equipment.fromMap(item);
          }).toList(),
          locations: data['carePathWay'].map<locationInHospital>((location) {
            return locationInHospital.fromMap(location);
          }).toList(),
          medicalSupplies: data['medicalSupplies'].map<medicalSupply>((supply) {
            return medicalSupply.fromMap(supply);
          }).toList(),
        );

   mapifyList(List input) {
    List<Map> newList = [];

    input.forEach((item) {
      newList.add(item.toMap());
    });

    return newList.toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'govtID': govtID,
      'hospitalName': hospitalName,
      'fullAddress': fullAddress.toMap(),
      'equipments': mapifyList(equipments),
      'carePathWay': mapifyList(locations),
      'medicalSupplies':mapifyList(medicalSupplies),

    };
  }
}
