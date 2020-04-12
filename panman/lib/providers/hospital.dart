import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/medicalSupply.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FetchedMedicalSupply {
  String id;
  String name;

  FetchedMedicalSupply({this.id, this.name});
}

class FetchedHospitalLocationReference {
  String id;
  String name;

  FetchedHospitalLocationReference({this.id, this.name});
}

class Hospitals with ChangeNotifier {
  var hospitalsCollection = Firestore.instance.collection('hospitals');
  var hospitalSnapshot;

  List<FetchedMedicalSupply> referenceMedicalSupplyList = [];
  List<FetchedHospitalLocationReference> referenceHospitalLocationList = [];

  Hospital fetchedHospital = Hospital(hospitalName: "loading..");

  bool isUpdating = false;

  Future getReferenceMedicalSupplyList() async {
    try {
      referenceMedicalSupplyList.clear();
      referenceHospitalLocationList.clear();
      var medicalSupplyCollection =
          Firestore.instance.collection('medicalSupplyDetails');

      var newList = await medicalSupplyCollection.getDocuments();
      //  print(newList.documents);
      newList.documents.forEach((element) {
        print(element['Name'] + element['id']);
        referenceMedicalSupplyList.add(
            FetchedMedicalSupply(name: element['Name'], id: element['id']));
      });

      notifyListeners();

    } catch (e) {
      print(e);
    }
  }

  Future getReferenceHospitalLocationList() async {
    try {
      var hospitalReferenceCollection =
          Firestore.instance.collection('hospitalLocationReference');

      var newList =
          await hospitalReferenceCollection.orderBy('id').getDocuments();
      //  print(newList.documents);
      newList.documents.forEach((element) {
        print(element['name'] + element['id']);
        referenceHospitalLocationList.add(FetchedHospitalLocationReference(
            name: element['name'], id: element['id']));
      });

      notifyListeners();

    } catch (e) {
      print(e);
    }
  }

  String getMedicalSupplyNameFromId(String id) {
    var gotcha =
        referenceMedicalSupplyList.firstWhere((element) => element.id == id);
    return gotcha.name;
  }

  Future getHospitalDetailsFromServer(String hospitalID) async {
    try {
      print("Calling getHospitalDetails $hospitalID");
      hospitalSnapshot = await hospitalsCollection.document(hospitalID).get();
      print("Fetched ${hospitalSnapshot.data}");
      fetchedHospital = Hospital.fromMap(hospitalSnapshot.data);
      print("Fetched Hospital Name is" + fetchedHospital.toString());

      notifyListeners();

      return true;
    } catch (e) {
      print(e);
    }
  }

  Future getHospitalDetailsFromServerUsingAPI(String hospitalID) async {
    print("Calling getHospitalDetails $hospitalID");

    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
    // print("Fetched token is $token");
    try {
      final response = await http.get(
          'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/hospital/' +
              hospitalID,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          });
      if (response.statusCode == 200) {
        hospitalSnapshot = json.decode(response.body);
        print(hospitalSnapshot.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }
      //hospitalSnapshot = await hospitalsCollection.document(hospitalID).get();
      // print("Fetched ${hospitalSnapshot.data}");
      fetchedHospital = Hospital.fromMap(hospitalSnapshot.data);
      print("Fetched Hospital Name is" + fetchedHospital.toString());

      notifyListeners();

      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> decrementVentilatorCount() async {
    try {
      fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty - 1;
      await updateHospitalUsingAPI();

      // ventilatorCountAvailable = ventilatorCountAvailable-1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> incrementVentilatorCount() async {
    try {
      fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty + 1;

      await updateHospitalUsingAPI();

      //   ventilatorCountAvailable = ventilatorCountAvailable+1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future addPatientToTheHospital() async {
    try {
      var location =
          fetchedHospital.locations.indexWhere((element) => element.id == "2");

      fetchedHospital.locations[location].count =
          fetchedHospital.locations[location].count + 1;
      await updateHospitalUsingAPI();
    } catch (e) {
      print(e);
    }
  }

  Future movePatientOutOfHospital(String locationToBeDecremented) async {
    try {
      isUpdating = true;
      notifyListeners();
      var oldLocation = fetchedHospital.locations
          .indexWhere((element) => element.id == locationToBeDecremented);
      fetchedHospital.locations[oldLocation].count =
          fetchedHospital.locations[oldLocation].count - 1;
      await updateHospitalUsingAPI();
    } catch (e) {
      print(e);
    }
  }

  Future changeLocationInHospitalCount(
      String locationToBeIncremented, String locationToBeDecremented) async {
    try {
      var newLocation = fetchedHospital.locations
          .indexWhere((element) => element.id == locationToBeIncremented);

      fetchedHospital.locations[newLocation].count =
          fetchedHospital.locations[newLocation].count + 1;

      await updateHospitalUsingAPI();
    } catch (e) {
      print(e);
    }
  }

  Future updateQuantity(medicalSupply item, int newQuantity) async {
    print(newQuantity.toString());
    try {
      var itemToUpdate = fetchedHospital.medicalSupplies
          .indexWhere((element) => element.id == item.id);
      fetchedHospital.medicalSupplies[itemToUpdate].qty = newQuantity;
      print(fetchedHospital.medicalSupplies[itemToUpdate].qty);
      await updateHospitalUsingAPI();
    } catch (e) {
      print(e);
    }
  }

  getVentilatorCount() {
    return fetchedHospital.equipments[0].qty;
  }

  Future updateHospital() async {
    isUpdating = true;
    // updatingInFirebase = true;
    // finishedUpdatingFirebase = false;
    notifyListeners();
    try {
      await hospitalsCollection
          .document(fetchedHospital.id)
          .updateData(fetchedHospital.toMap());
      isUpdating = false;
      notifyListeners();

      // updatingInFirebase = false;
      // finishedUpdatingFirebase = true;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updateHospitalUsingAPI() async {
    isUpdating = true;
    // updatingInFirebase = true;
    // finishedUpdatingFirebase = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    // print("userData+${userData}");
    var decodedJson = json.decode(userData);
    var token = decodedJson['token'];
    try {
      final response = await http.put(
          'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/hospital/' +
              fetchedHospital.id,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          },
          body: json.encode(fetchedHospital.toMap()),
);
      if (response.statusCode == 200) {
        hospitalSnapshot = json.decode(response.body);
        print("This is the request body of the hospital UPDATE"+hospitalSnapshot.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }
      isUpdating = false;
      notifyListeners();


      // updatingInFirebase = false;
      // finishedUpdatingFirebase = true;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
