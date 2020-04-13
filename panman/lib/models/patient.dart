import './address.dart';
import './c19data.dart';
import './event.dart';
import './patientVital.dart';
import './locationInHospital.dart';
import './travelHistory.dart';
import './delhiSpecificDetails.dart';
import './test.dart';
import './screening.dart';
import './emergency_contact.dart';

import 'dart:io';

enum Sex { Male, Female, Other}

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
  DelhiSpecificDetails delhiDetails;
  File pic;
  List<Test> tests;
  Screening screeningResult;
  String emergencyContactRelation;
  String emergencyContactFirstName;
  String emergencyContactLastName;
  String emergencyContactPhoneNumber;

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
    this.delhiDetails,
    this.pic,
    this.tests,
    this.screeningResult,
    this.emergencyContactFirstName,
    this.emergencyContactLastName,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelation,
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
      'sex': sex == Sex.Male ? "Male" : sex== Sex.Female?"Female" :"Other",
      'ventilatorUsed': ventilatorUsed,
      'locationInHospital': this.currentLocation,
      'hospitalID': this.hospitalID,
      'phoneNumber':this.phoneNumber,
      'covidStatus': this.state.abbrv,
      'fullAddress': fullAddress != null ? fullAddress.toMap() : "",
      'firstName': Firstname,
      'lastName': LastName,
      'events': mapifyList(events),
      'vitals': mapifyList(vitals),
      'delhiDetails': delhiDetails != null ? delhiDetails.toMap() : "",
      'tests': mapifyList(tests),
      'screeningResult':screeningResult!=null?screeningResult.toMap():"",
      'emergencyContactFirstName':emergencyContactFirstName,
      'emergencyContactLastName':emergencyContactLastName,
      'emergencyContactPhoneNumber':emergencyContactPhoneNumber,
      'emergencyContactRelation':emergencyContactRelation,


    };
  }
}
