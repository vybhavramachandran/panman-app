import 'package:random_string/random_string.dart';

import '../models/patient.dart';
import '../models/c19data.dart';
import '../models/address.dart';
import '../models/event.dart';

import '../models/patient_vitals/consciousness.dart';
import '../models/patient_vitals/fi02.dart';
import '../models/patient_vitals/flowrate.dart';
import '../models/patient_vitals/mode.dart';
import '../models/patient_vitals/periphery.dart';
import '../models/patient_vitals/position.dart';
import '../models/patient_vitals/rhythm.dart';

import '../models/patientVital.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class Patients with ChangeNotifier {
  List<Patient> fetchedPatientsList = [];
  Patient selectedPatient;
  bool stateChanged = true;
  bool isUpdating = false;
  bool isFetching = false;
  bool isAddingPatient = false;
  bool shouldRefreshList = false;

  var patientsCollection = Firestore.instance.collection('patients');

  var patientSnapshot;

  Future fetchPatientsListFromServer(String hospitalID) async {
    print("fetchPatientsList Called");

    isFetching = true;
    //notifyListeners();
    fetchedPatientsList.clear();
    patientSnapshot = await patientsCollection
        .where('hospitalID', isEqualTo: hospitalID)
        .getDocuments();
    patientSnapshot.documents.forEach((patient) async {
      print(patient['firstName'] + patient['covidStatus']);
      fetchedPatientsList.add(Patient(
        Firstname: patient['firstName'],
        LastName: patient['lastName'],
        age: patient['age'],
        currentLocation: patient['locationInHospital'],
        state: referenceCovid19SeverityLevelsList
            .firstWhere((element) => element.abbrv == patient['covidStatus']),
        fullAddress: FullAddress.fromMap(patient['fullAddress']),
        sex: patient['sex'] == "Male" ? Sex.Male : Sex.Female,
        ventilatorUsed: patient['ventilatorUsed'],
        id: patient['id'],
        phoneNumber: patient['phoneNumber'],
        hospitalID: patient['hospitalID'],
        idGivenByHospital: patient['idGivenByHospital'],
        events: patient['events'] == null
            ? []
            : patient['events'].map<event>((eventToBeAdded) {
                return event.fromMap(eventToBeAdded);
              }).toList(),
        vitals: patient['vitals'] == null
            ? []
            : patient['vitals'].map<PatientVital>((vitalToBeAdded) {
                return PatientVital.fromMap(vitalToBeAdded);
              }).toList(),
      ));
    });
    isFetching = false;
    shouldRefreshList = false;
    notifyListeners();
  }

  Future addVitalMeasurement(PatientVital vital) async {
    selectedPatient.vitals.add(vital);
    await updatePatientProfileInFirebase();
    notifyListeners();
  }

  Future<Patient> fetchPatientDetailsFromAPI(String patientID) async {
    print("Test");
  }

  mapifyList(List input) {
    List<Map> newList = [];

    input.forEach((item) {
      newList.add(item.toMap());
    });

    return newList.toList();
  }

  selectPatient(String patientID) {
    selectedPatient =
        fetchedPatientsList.firstWhere((patient) => patient.id == patientID);
    notifyListeners();
  }

  getCovidvsNonCovidforDashboard() {
    var covidCount = fetchedPatientsList
        .where((element) => !element.state.abbrv.contains("NP"))
        .length;

    var nonCovidCount = fetchedPatientsList
        .where((element) => element.state.abbrv.contains("NP"))
        .length;

    return ([covidCount, nonCovidCount]);
  }

  getCovid19SummaryForTheDashboard() {
    List covid19Summary;
    var AS1patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "AS-1")
        .length;
    var AS2patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "AS-2")
        .length;
    var S1patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-1")
        .length;
    var S2patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-2")
        .length;
    var S3patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-3")
        .length;
    var S4patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-4")
        .length;
    var S5patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-5")
        .length;
    var S6patientcount = fetchedPatientsList
        .where((element) => element.state.abbrv == "S-6")
        .length;

    return ([
      AS1patientcount,
      AS2patientcount,
      S1patientcount,
      S2patientcount,
      S3patientcount,
      S4patientcount,
      S5patientcount,
      S6patientcount
    ]);
  }

  Future<bool> movePatient(int newLocation) async {
    var oldLocation = selectedPatient.currentLocation;
    selectedPatient.currentLocation = newLocation;

    isUpdating = true;
    notifyListeners();

    if (newLocation == 7) {
      selectedPatient.hospitalID = "";

      await addEvent(
          eventType: "patient_death",
          eventTime: DateTime.now(),
          eventData: "${oldLocation}->${newLocation}");
      await updatePatientProfileInFirebase();
    } else if (newLocation == 6) {
      selectedPatient.hospitalID = "";
      await addEvent(
          eventType: "patient_transfer",
          eventTime: DateTime.now(),
          eventData: "${oldLocation}->${newLocation}");
      await updatePatientProfileInFirebase();
    } 
    else if (newLocation == 0) {
      selectedPatient.hospitalID = "";
      await addEvent(
          eventType: "patient_discharged",
          eventTime: DateTime.now(),
          eventData: "${oldLocation}->${newLocation}");
      await updatePatientProfileInFirebase();
    } else {
      await addEvent(
          eventType: "hospital_movement",
          eventTime: DateTime.now(),
          eventData: "${oldLocation}->${newLocation}");
      await updatePatientProfileInFirebase();
    }

    isUpdating=false;
    notifyListeners();

    return true;
  }

  Future<bool> changePatientState(int newStateIndex) async {
    c19 oldState = selectedPatient.state;
    selectedPatient.state =
        referenceCovid19SeverityLevelsList[newStateIndex + 2];
    await addEvent(
        eventType: "covid19_severity_change",
        eventTime: DateTime.now(),
        eventData: "${oldState.abbrv}->${selectedPatient.state.abbrv}");
    await updatePatientProfileInFirebase();

    notifyListeners();
    return true;
  }

  Future<bool> toggleVentilatorAssignment(bool newValue) async {
    selectedPatient.ventilatorUsed = newValue;
    await addEvent(
        eventType: "ventilator",
        eventTime: DateTime.now(),
        eventData: newValue.toString());
    await updatePatientProfileInFirebase();
    notifyListeners();
    return true;
  }

  Future<bool> addPatient(Patient patientToAdd) async {
    isAddingPatient = true;
    notifyListeners();
    var patientsCollection = Firestore.instance.collection('patients');
    event newEvent = event(
        eventType: "hospital_admission",
        eventData: patientToAdd.hospitalID,
        eventDateTime: DateTime.now(),
        eventID: randomAlphaNumeric(20));
    patientToAdd.events.add(newEvent);
    await patientsCollection.document(patientToAdd.id).setData(
          patientToAdd.toMap(),
        );
    isAddingPatient = false;
    shouldRefreshList = true;
    notifyListeners();
    return true;
  }

  Future<bool> addEvent(
      {String patientID,
      String eventType,
      DateTime eventTime,
      String eventData}) async {
    event newEvent = event(
        eventType: eventType,
        eventData: eventData,
        eventDateTime: eventTime,
        eventID: randomAlphaNumeric(20));
    selectedPatient.events.add(newEvent);
    notifyListeners();
/*
    if (eventType == "hospital_registration") {
      await patientsCollection.document(patientID).updateData({
        'events': FieldValue.arrayUnion([newEvent.toMap()])
      });
    } else {
      await patientsCollection.document(selectedPatient.id).updateData({
        'events': FieldValue.arrayUnion([newEvent.toMap()])
      });
    }*/

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

  onSearchTextChanged(String searchTerm) {
    filteredPatientsList.clear();
    notifyListeners();
    print("Calling this, $searchTerm");
    fetchedPatientsList.forEach((patient) {
      if (patient.Firstname.contains(searchTerm) ||
          patient.LastName.contains(searchTerm)) {
        filteredPatientsList.add(patient);
        print(patient.Firstname);
      }
    });
    notifyListeners();
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
