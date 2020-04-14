import 'dart:io';

import './address.dart';
import './c19data.dart';
import './delhiSpecificDetails.dart';
import './event.dart';
import './patientVital.dart';
import './test.dart';
import './travelHistory.dart';

enum Sex { Male, Female }

class Patient {
  String id;
  String idGivenByHospital;
  String Firstname;
  String LastName;
  int age;
  Sex sex;
  FullAddress fullAddress;
  String hospitalID;
  String phoneNumber;
  c19 state;
  int currentLocation;
  bool ventilatorUsed;
  List<event> events;
  List<PatientVital> vitals;
  File pic;
  List<TravelHistory> travelHistory;
  DelhiSpecificDetails delhiDetails;
  List<Test> tests;

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
    this.vitals,
    this.travelHistory,
    this.delhiDetails,
    this.pic,
    this.tests,
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
      'idGivenByHospital': idGivenByHospital,
      'age': age,
      'sex': sex == Sex.Male ? "Male" : "Female",
      'ventilatorUsed': ventilatorUsed,
      'locationInHospital': this.currentLocation,
      'hospitalID': this.hospitalID,
      'covidStatus': this.state.abbrv,
      'fullAddress': fullAddress != null ? fullAddress.toMap() : "",
      'firstName': Firstname,
      'lastName': LastName,
      'events': mapifyList(events),
      'vitals': mapifyList(vitals),
      'delhiDetails': delhiDetails != null ? delhiDetails.toMap() : "",
      'travelHistory': travelHistory != null ? mapifyList(travelHistory) : "",
      'tests': tests != null ? mapifyList(tests) : "",
    };
  }
}
