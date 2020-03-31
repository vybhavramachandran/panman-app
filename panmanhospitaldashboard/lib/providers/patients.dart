import 'dart:convert';

import '../models/patient.dart';
import '../models/c19data.dart';
import '../models/address.dart';

import '../models/locationInHospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class Patients with ChangeNotifier {
  List<Patient> fetchedPatientsList = [];
  Patient selectedPatient;
  bool stateChanged = true;
  bool isUpdating = false;
  bool isFetching = false;

  var patientsCollection = Firestore.instance.collection('patients');

  var patientSnapshot;

  Future fetchPatientsListFromServer(String hospitalID) async {
    print("fetchPatientsList Called");
    isFetching = true;
    notifyListeners();
    fetchedPatientsList.clear();
    patientSnapshot = await patientsCollection
        .where('hospitalID', isEqualTo: hospitalID)
        .getDocuments();
    patientSnapshot.documents.forEach((patient) async {
      fetchedPatientsList.add(Patient(
        Firstname: patient['firstName'],
        LastName: patient['lastName'],
        age: patient['age'],
        currentLocation: patient['locationInHospital'],
        state: c19states[patient['covidStatus']],
        fullAddress: FullAddress.fromMap(patient['fullAddress']),
        sex: patient['sex'] == "Male" ? Sex.Male : Sex.Female,
        ventilatorUsed: patient['ventilatorUsed'],
        id: patient['id'],
        hospitalID: patient['hospitalID'],
      ));
    });
    isFetching = false;
    notifyListeners();
  }

  Future<Patient> fetchPatientDetailsFromAPI(String patientID) async {
    print("Test");
  }

  selectPatient(String patientID) {
    selectedPatient =
        fetchedPatientsList.firstWhere((patient) => patient.id == patientID);
    notifyListeners();
  }

  Future<bool> movePatient(int newLocation) async {
    selectedPatient.currentLocation = newLocation;
    await updatePatientProfileInFirebase();

    notifyListeners();
    return true;
  }

  Future<bool> changePatientState(C19PatientState newState) async {
    selectedPatient.state = c19states[newState.index];
    await updatePatientProfileInFirebase();
    notifyListeners();
    return true;
  }

  Future<bool> toggleVentilatorAssignment(bool newValue) async {
    selectedPatient.ventilatorUsed = newValue;
    await updatePatientProfileInFirebase();
    notifyListeners();
    return true;
  }

  Future<bool> addPatient(Patient patientToAdd) async {
    var patientsCollection = Firestore.instance.collection('patients');
    var patient_id = await patientsCollection.add(
      patientToAdd.toMap(),
    );

    await patientsCollection.document(patient_id.documentID).updateData({
      'id': patient_id.documentID});

    return true;
  }

  Future updatePatientProfileInFirebase() async {
    var patientsCollection = Firestore.instance.collection('patients');
    isUpdating = true;
    // updatingInFirebase = true;
    // finishedUpdatingFirebase = false;
    notifyListeners();

    await patientsCollection
        .document(selectedPatient.id)
        .updateData(selectedPatient.toMap());
    isUpdating = false;
    notifyListeners();
    // updatingInFirebase = false;
    // finishedUpdatingFirebase = true;
    // notifyListeners();
  }

  List<Patient> filteredPatientsList = [
    //   Patient(
    //     Firstname: "dummy1",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "1",
    //     state: C19PatientState.S5,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy2",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "2",
    //     state: C19PatientState.S4,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy3",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "3",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy4",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "4",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "5",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "6",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "7",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "8",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "9",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "10",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "11",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "12",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "13",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "14",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "15",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "16",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "17",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
    //   Patient(
    //     Firstname: "dummy",
    //     LastName: "dummy",
    //     DoB: DateTime(1987, 03, 30),
    //     sex: Sex.Male,
    //     id: "18",
    //     state: C19PatientState.AS1,
    //     currentLocation: 1,
    //     ventilatorUsed: false,
    //   ),
  ];
}
