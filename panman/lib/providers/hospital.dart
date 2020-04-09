import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/medicalSupply.dart';
import 'package:panman/utils/analytics_client.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

      Analytics.instance.logEvent(name: 'getReferenceMedicalSupplyList');
    } catch (e) {
      print(e);
    }
  }

  Future getReferenceMedicalSupplyListFromAPI() async {
    var medicalSupplySnapshot;

    try {
      referenceMedicalSupplyList.clear();
      referenceHospitalLocationList.clear();

      //  print(newList.documents);
      final response =
          await http.get('https://jsonplaceholder.typicode.com/albums/1');
      if (response.statusCode == 200) {
        medicalSupplySnapshot = json.decode(response.body);
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }

      medicalSupplySnapshot.documents.forEach((element) {
        print(element['Name'] + element['id']);
        referenceMedicalSupplyList.add(
            FetchedMedicalSupply(name: element['Name'], id: element['id']));
      });

      notifyListeners();

      Analytics.instance.logEvent(name: 'getReferenceMedicalSupplyList');
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
      Analytics.instance.logEvent(name: 'getReferenceHospitalLocationList');
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
      Analytics.instance.logEvent(name: 'getHospitalDetailsFromServer');
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> decrementVentilatorCount() async {
    try {
      fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty - 1;
      await updateHospital();

      // ventilatorCountAvailable = ventilatorCountAvailable-1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> incrementVentilatorCount() async {
    try {
      fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty + 1;

      await updateHospital();

      //   ventilatorCountAvailable = ventilatorCountAvailable+1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future addPatientToTheHospital() async {
    try {
      var location =
          fetchedHospital.locations.indexWhere((element) => element.id == "1");

      fetchedHospital.locations[location].count =
          fetchedHospital.locations[location].count + 1;
      await updateHospital();
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
      await updateHospital();
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

      await updateHospital();
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
      await updateHospital();
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

      Analytics.instance.logEvent(
          name: 'getHospitalDetailsFromServer',
          parameters: fetchedHospital.toMap());

      // updatingInFirebase = false;
      // finishedUpdatingFirebase = true;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
