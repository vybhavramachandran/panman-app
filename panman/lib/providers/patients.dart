import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:panman/models/contactTracing.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encryption;
import 'package:flutter_cipher/flutter_cipher.dart';

import '../models/address.dart';
import '../models/c19data.dart';
import '../models/event.dart';
import '../models/screening.dart';
import '../models/patient.dart';
import '../models/patientVital.dart';
import '../models/travelHistory.dart';
import '../models/delhiSpecificDetails.dart';
import '../models/test.dart';
import '../keys/key.dart';

class Patients with ChangeNotifier {
  static final newKey = encryption.Key.fromUtf8(aes_key);
  static final newiv = encryption.IV.fromUtf8(aes_iv);

  final encrypter = encryption.Encrypter(encryption.AES(newKey));

  

  List<Patient> fetchedPatientsList = [];
  Patient selectedPatient;
  Patient newPatient = Patient();
  bool stateChanged = true;
  bool isUpdating = false;
  bool isFetching = false;
  bool isAddingPatient = false;
  bool shouldRefreshList = false;

  var patientsCollection = Firestore.instance.collection('patients');

  var patientSnapshot;

  Future fetchPatientsListFromServer(String hospitalID) async {
    print("fetchPatientsList Called");

    DelhiSpecificDetails dummyDetails = DelhiSpecificDetails(
      district: "",
      fromMarkaz: false,
      revenueDistrict: "",
    );

    contactTracing dummyContact = contactTracing(
      isMorePatientInfoAvailable: false,
      sourceOfInfection: "",
      sourcePatientAddress: "",
      sourcePatientFirstName: "",
      sourcePatientLastName: "",
    );

    Screening dummyScreening = Screening(
      hasComorbdityOrganTransplant: false,
      hasComorbidityCOPD: false,
      hasComorbidityChronicNeuro: false,
      hasComorbidityChronicRenalDisease: false,
      hasComorbidityDiabetes: false,
      hasComorbidityHIV: false,
      hasComorbidityHeartDisease: false,
      hasComorbidityHypertension: false,
      hasComorbidityLiverDisease: false,
      hasComorbidityMalignancy: false,
      hasComorbidityPregnancy: false,
      hasCough: false,
      hasDifficultyBreathing: false,
      hasFever: false,
      hasTravelledAboard: false,
      hasTiredness: false,
      returnDate: DateTime.now(),
      visitedCountry: "No Data",
    );

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
          sex: patient['sex'] == "Male"
              ? Sex.Male
              : patient['sex'] == "Female" ? Sex.Female : Sex.Other,
          ventilatorUsed: patient['ventilatorUsed'],
          id: patient['id'],
          phoneNumber: patient['phoneNumber'],
          hospitalID: patient['hospitalID'],
          screeningResult: patient['screeningResult'] == null ||
                  patient['screeningResult'] == ""
              ? dummyScreening
              : Screening.fromMap(patient['screeningResult']),
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
          // travelHistory: patient['travelHistory'] == null
          //     ? []
          //     : patient['travelHistory'].map<TravelHistory>((travel) {
          //         return TravelHistory.fromMap(travel);
          //       }).toList(),
          delhiDetails: patient['delhiDetails'] == null
              ? dummyDetails
              : DelhiSpecificDetails.fromMap(patient['delhiDetails']),
          tests: patient['tests'] == null
              ? []
              : patient['tests'].map<Test>((testToBeAdded) {
                  return Test.fromMap(testToBeAdded);
                }).toList(),
          tracingDetail: patient['tracingDetail'] == null
              ? dummyContact
              : contactTracing.fromMap(patient['tracingDetail']),
        ));
      });
      isFetching = false;
      shouldRefreshList = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future fetchPatientsListFromServerAPI2(String hospitalID) async {
    print("fetchPatientsList Called");

    DelhiSpecificDetails dummyDetails = DelhiSpecificDetails(
      district: "",
      fromMarkaz: false,
      revenueDistrict: "",
    );

    Screening dummyScreening = Screening(
      hasComorbdityOrganTransplant: false,
      hasComorbidityCOPD: false,
      hasComorbidityChronicNeuro: false,
      hasComorbidityChronicRenalDisease: false,
      hasComorbidityDiabetes: false,
      hasComorbidityHIV: false,
      hasComorbidityHeartDisease: false,
      hasComorbidityHypertension: false,
      hasComorbidityLiverDisease: false,
      hasComorbidityMalignancy: false,
      hasComorbidityPregnancy: false,
      hasCough: false,
      hasDifficultyBreathing: false,
      hasFever: false,
      hasTravelledAboard: false,
      hasTiredness: false,
      returnDate: DateTime.now(),
      visitedCountry: "No Data",
    );

    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
    try {
      isFetching = true;

      //notifyListeners();
      fetchedPatientsList.clear();

      final response = await http.get(
          'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/patient/hospitalid/' +
              hospitalID,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          });
      if (response.statusCode == 200) {
        patientSnapshot = json.decode(response.body);
        print(patientSnapshot.toString());
        notifyListeners();
      } else {
        throw Exception('Fetch Patients Failed');
      }

      patientSnapshot.forEach((patient) async {
        print(patient['firstName'] + patient['covidStatus']);

        fetchedPatientsList.add(Patient(
          Firstname: patient['firstName'],
          LastName: patient['lastName'],
          age: patient['age'],
          currentLocation: patient['locationInHospital'],
          state: referenceCovid19SeverityLevelsList
              .firstWhere((element) => element.abbrv == patient['covidStatus']),
          fullAddress: FullAddress.fromMap(patient['fullAddress']),
          sex: patient['sex'] == "Male"
              ? Sex.Male
              : patient['sex'] == "Female" ? Sex.Female : Sex.Other,
          ventilatorUsed: patient['ventilatorUsed'],
          id: patient['id'],
          phoneNumber: patient['phoneNumber'],
          hospitalID: patient['hospitalID'],
          screeningResult: patient['screeningResult'] == null ||
                  patient['screeningResult'] == ""
              ? dummyScreening
              : Screening.fromMap(patient['screeningResult']),
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
          // travelHistory: patient['travelHistory'] == null
          //     ? []
          //     : patient['travelHistory'].map<TravelHistory>((travel) {
          //         return TravelHistory.fromMap(travel);
          //       }).toList(),
          delhiDetails: patient['delhiDetails'] == null
              ? dummyDetails
              : DelhiSpecificDetails.fromMap(patient['delhiDetails']),
          tests: patient['tests'] == null
              ? []
              : patient['tests'].map<Test>((testToBeAdded) {
                  return Test.fromMap(testToBeAdded);
                }).toList(),
          tracingDetail: patient['tracingDetail'],
        ));
      });
      isFetching = false;
      shouldRefreshList = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future editScrening(Screening screeningVal) async {
    isAddingPatient = true;
    notifyListeners();
    try {
      selectedPatient.screeningResult = screeningVal;
      await updatePatientProfileInFirebase();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    isAddingPatient = false;
    notifyListeners();
  }

  Future addScreening(Screening screeningVal, int location) async {
    isAddingPatient = true;
    notifyListeners();
    try {
      selectedPatient.screeningResult = screeningVal;
      selectedPatient.currentLocation = location;
      await updatePatientProfileInFirebase();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    isAddingPatient = false;
    notifyListeners();
  }

  Future editContactTracking(contactTracing newTracing) async {
    isUpdating = true;
    notifyListeners();
    try {
      selectedPatient.tracingDetail = newTracing;
      await updatePatientProfileInFirebase();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    isUpdating = false;
    notifyListeners();
  }

  Future addContactTracking(contactTracing newTracing, int location) async {
    isUpdating = true;
    notifyListeners();
    try {
      selectedPatient.tracingDetail = newTracing;
      selectedPatient.currentLocation = location;
      await updatePatientProfileInFirebase();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    isUpdating = false;
    notifyListeners();
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
      } else if (newLocation == 0) {
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

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // String encryptThis({String plainText}) {
  //   var value = encrypter.encrypt(plainText, iv: newiv);
  //   return value.base64;
  // }

  // String decryptThis({String encryptedText}) {
  //   return encrypter.decrypt64(encryptedText);
  // }

  Future<bool> addPatient(Patient patientReceived) async {
    Patient patientToAdd = patientReceived;
    patientToAdd.Firstname = patientToAdd.Firstname;
    patientToAdd.LastName = patientToAdd.LastName;
    patientToAdd.phoneNumber = patientToAdd.phoneNumber;

    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
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

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addPatientUsingApi(Patient patientToAdd) async {
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    print("Add Patient called ${patientToAdd}");
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
    try {
      isAddingPatient = true;
      notifyListeners();
      print("Hospital ID is" + patientToAdd.hospitalID);
      event newEvent = event(
          eventType: "hospital_admission",
          eventData: patientToAdd.hospitalID,
          eventDateTime: DateTime.now(),
          eventID: randomAlphaNumeric(20));
      patientToAdd.events.add(newEvent);
      var test = json.encode(patientToAdd.toMap());
      //  print(patientToAdd.toMap().toString());

      final response = await http.post(
        'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/patient/${patientToAdd.id}',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        body: json.encode(patientToAdd.toMap()),
      );
      if (response.statusCode == 200) {
        print("Patient added successfully");
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }

      isAddingPatient = false;
      shouldRefreshList = true;
      notifyListeners();

      // Analytics.instance.logEvent(name: 'addPatient', parameters: {
      //   'eventType': 'hospital_admission',
      //   'eventTime': DateTime.now(),
      //   'eventData': patientToAdd.hospitalID,
      //   'eventID': randomAlphaNumeric(20),
      // });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future addTest(Test testToAdd) async {
    print("addTest called ${testToAdd.resultDate}");

    try {
      selectedPatient.tests.add(testToAdd);
      await updatePatientProfileInFirebase();
      notifyListeners();
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
      Patient patientToAdd = selectedPatient;
      patientToAdd.Firstname = patientToAdd.Firstname;
      patientToAdd.LastName = patientToAdd.LastName;
      patientToAdd.phoneNumber =
           patientToAdd.phoneNumber;
      await patientsCollection
          .document(selectedPatient.id)
          .updateData(patientToAdd.toMap());
      isUpdating = false;
      notifyListeners();

      // updatingInFirebase = false;
      // finishedUpdatingFirebase = true;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updatePatientProfileInFirebaseWithAPI2() async {
    print("update Patient also called ${selectedPatient.id}");
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
    try {
      //    var patientsCollection = Firestore.instance.collection('patients');
      isUpdating = true;
      // updatingInFirebase = true;
      // finishedUpdatingFirebase = false;
      notifyListeners();
      print(token);
      print(json.encode(selectedPatient.toMap()));
      final response = await http.put(
        'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/patient/' +
            selectedPatient.id,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        body: json.encode(selectedPatient.toMap()),
      );
      if (response.statusCode == 200) {
        print(response.body.toString());
        print("Patient updated successfully");
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }
      isUpdating = false;
      notifyListeners();

      // Analytics.instance
      //     .logEvent(name: 'addPatient', parameters: selectedPatient.toMap());

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
      if (patient.Firstname.toLowerCase().contains(searchTerm) ||
          patient.LastName.toLowerCase().contains(searchTerm) ||
          patient.idGivenByHospital.toLowerCase().contains(searchTerm)) {
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
