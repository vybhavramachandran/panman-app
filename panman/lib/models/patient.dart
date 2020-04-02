import './address.dart';
import './c19data.dart';
import './locationInHospital.dart';

enum Sex { Male, Female }

class patient_event {
  DateTime timestamp;
  String event;
}

class Patient {
  final String id;
  final String Firstname;
  final String LastName;
  final int age;
  final Sex sex;
  final FullAddress fullAddress;
  final String hospitalID;
  c19 state;
  int currentLocation;
  List<patient_event> events;
  bool ventilatorUsed;

  Patient({
    this.id,
    this.hospitalID,
    this.Firstname,
    this.LastName,
    this.age,
    this.sex,
    this.fullAddress,
    this.state,
    this.currentLocation,
    this.ventilatorUsed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'age': age,
      'sex': sex == Sex.Male ? "Male" : "Female",
      'ventilatorUsed': ventilatorUsed,
      'locationInHospital': this.currentLocation,
      'hospitalID': this.hospitalID,
      'covidStatus': this.state.abbrv,
      'fullAddress': fullAddress!=null?fullAddress.toMap():"",
      'firstName': Firstname,
      'lastName': LastName,
    };
  }
}
