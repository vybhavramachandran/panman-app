import './address.dart';
import './c19data.dart';
import './event.dart';
import './locationInHospital.dart';

enum Sex { Male, Female }


class Patient {
  final String id;
  String idGivenByHospital;
  final String Firstname;
  final String LastName;
  final int age;
  final Sex sex;
  final FullAddress fullAddress;
  final String hospitalID;
  String phoneNumber;
  c19 state;
  int currentLocation;
  bool ventilatorUsed;
  List<event> events;

  Patient({
    this.id,
    this.hospitalID,
    this.Firstname,
    this.LastName,
    this.age,
    this.sex,
    this.idGivenByHospital,
    this.fullAddress,
    this.phoneNumber,
    this.state,
    this.currentLocation,
    this.ventilatorUsed,
    this.events,
  });

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
      'idGivenByHospital' : idGivenByHospital,
      'age': age,
      'sex': sex == Sex.Male ? "Male" : "Female",
      'ventilatorUsed': ventilatorUsed,
      'locationInHospital': this.currentLocation,
      'hospitalID': this.hospitalID,
      'covidStatus': this.state.abbrv,
      'fullAddress': fullAddress!=null?fullAddress.toMap():"",
      'firstName': Firstname,
      'lastName': LastName,
      'events': mapifyList(events),
    };
  }
}
