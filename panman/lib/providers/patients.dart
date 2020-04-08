import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:panman/utils/analytics_client.dart';
import 'package:random_string/random_string.dart';

import '../models/address.dart';
import '../models/c19data.dart';
import '../models/event.dart';
import '../models/patient.dart';
import '../models/patientVital.dart';

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

    try {
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
      Analytics.instance.logEvent(name: 'fetchPatientsListFromServer');
      isFetching = false;
      shouldRefreshList = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future addVitalMeasurement(PatientVital vital) async {
    try {
      selectedPatient.vitals.add(vital);
      await updatePatientProfileInFirebase();
      notifyListeners();
    } catch (e) {
      print(e);
    }
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
    try {
      var oldLocation = selectedPatient.currentLocation;
      selectedPatient.currentLocation = newLocation;

      isUpdating = true;
      notifyListeners();

      Analytics.instance.logEvent(name: 'movePatient');

      if (newLocation == 7) {
        selectedPatient.hospitalID = "";

        await addEvent(
            eventType: "patient_death",
            eventTime: DateTime.now(),
            eventData: "${oldLocation}->${newLocation}");
        await updatePatientProfileInFirebase();

        Analytics.instance.logEvent(name: 'movePatient', parameters: {
          'eventType': 'patient_death',
          'eventTime': DateTime.now(),
          'eventData': "$oldLocation->$newLocation",
        });
      } else if (newLocation == 6) {
        selectedPatient.hospitalID = "";
        await addEvent(
            eventType: "patient_transfer",
            eventTime: DateTime.now(),
            eventData: "${oldLocation}->${newLocation}");
        await updatePatientProfileInFirebase();
        Analytics.instance.logEvent(name: 'movePatient', parameters: {
          'eventType': 'patient_transfer',
          'eventTime': DateTime.now(),
          'eventData': "$oldLocation->$newLocation",
        });
      } else if (newLocation == 0) {
        selectedPatient.hospitalID = "";
        await addEvent(
            eventType: "patient_discharged",
            eventTime: DateTime.now(),
            eventData: "${oldLocation}->${newLocation}");
        await updatePatientProfileInFirebase();
        Analytics.instance.logEvent(name: 'movePatient', parameters: {
          'eventType': 'patient_discharged',
          'eventTime': DateTime.now(),
          'eventData': "$oldLocation->$newLocation",
        });
      } else {
        await addEvent(
            eventType: "hospital_movement",
            eventTime: DateTime.now(),
            eventData: "${oldLocation}->${newLocation}");
        await updatePatientProfileInFirebase();
        Analytics.instance.logEvent(name: 'movePatient', parameters: {
          'eventType': 'hospital_movement',
          'eventTime': DateTime.now(),
          'eventData': "$oldLocation->$newLocation",
        });
      }

      isUpdating = false;
      notifyListeners();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changePatientState(int newStateIndex) async {
    try {
      c19 oldState = selectedPatient.state;
      selectedPatient.state =
          referenceCovid19SeverityLevelsList[newStateIndex + 2];
      await addEvent(
          eventType: "covid19_severity_change",
          eventTime: DateTime.now(),
          eventData: "${oldState.abbrv}->${selectedPatient.state.abbrv}");
      await updatePatientProfileInFirebase();

      notifyListeners();

      Analytics.instance.logEvent(name: 'changePatientState', parameters: {
        'eventType': 'covid19_severity_change',
        'eventTime': DateTime.now(),
        'eventData': "${oldState.abbrv}->${selectedPatient.state.abbrv}",
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> toggleVentilatorAssignment(bool newValue) async {
    try {
      selectedPatient.ventilatorUsed = newValue;
      await addEvent(
          eventType: "ventilator",
          eventTime: DateTime.now(),
          eventData: newValue.toString());
      await updatePatientProfileInFirebase();
      notifyListeners();

      Analytics.instance
          .logEvent(name: 'toggleVentilatorAssignment', parameters: {
        'eventType': 'ventilator',
        'eventTime': DateTime.now(),
        'eventData': newValue.toString(),
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addPatient(Patient patientToAdd) async {
    try {
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

      Analytics.instance.logEvent(name: 'addPatient', parameters: {
        'eventType': 'hospital_admission',
        'eventTime': DateTime.now(),
        'eventData': patientToAdd.hospitalID,
        'eventID': randomAlphaNumeric(20),
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addEvent(
      {String patientID,
      String eventType,
      DateTime eventTime,
      String eventData}) async {
    try {
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
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future updatePatientProfileInFirebase() async {
    try {
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

      Analytics.instance
          .logEvent(name: 'addPatient', parameters: selectedPatient.toMap());

      // updatingInFirebase = false;
      // finishedUpdatingFirebase = true;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
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

    Analytics.instance.logSearch(text: searchTerm);
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
