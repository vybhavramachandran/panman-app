import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/medicalSupply.dart';

import '../models/patient.dart';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    referenceMedicalSupplyList.clear();
    referenceHospitalLocationList.clear();
    var medicalSupplyCollection =
        Firestore.instance.collection('medicalSupplyDetails');

    var newList = await medicalSupplyCollection.getDocuments();
    //  print(newList.documents);
    newList.documents.forEach((element) {
      print(element['Name'] + element['id']);
      referenceMedicalSupplyList
          .add(FetchedMedicalSupply(name: element['Name'], id: element['id']));
    });

    notifyListeners();
  }

  Future getReferenceHospitalLocationList() async {
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
  }

  String getMedicalSupplyNameFromId(String id) {
    var gotcha =
        referenceMedicalSupplyList.firstWhere((element) => element.id == id);
    return gotcha.name;
  }

  Future getHospitalDetailsFromServer(String hospitalID) async {
    print("Calling getHospitalDetails");
    hospitalSnapshot = await hospitalsCollection.document(hospitalID).get();
    fetchedHospital = Hospital.fromMap(hospitalSnapshot.data);
    print("Fetched Hospital Name is" + fetchedHospital.hospitalName);
    notifyListeners();
    return true;
  }

  Future<bool> decrementVentilatorCount() async {
    fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty - 1;
    await updateHospital();

    // ventilatorCountAvailable = ventilatorCountAvailable-1;
    notifyListeners();
  }

  Future<bool> incrementVentilatorCount() async {
    fetchedHospital.equipments[0].qty = fetchedHospital.equipments[0].qty + 1;

    await updateHospital();

    //   ventilatorCountAvailable = ventilatorCountAvailable+1;
    notifyListeners();
  }

  Future addPatientToTheHospital() async {
    var location =
        fetchedHospital.locations.indexWhere((element) => element.id == "1");

    fetchedHospital.locations[location].count =
        fetchedHospital.locations[location].count + 1;
    await updateHospital();
  }

  Future movePatientOutOfHospital(String locationToBeDecremented) async {
  isUpdating = true;
  notifyListeners();
    var oldLocation = fetchedHospital.locations
        .indexWhere((element) => element.id == locationToBeDecremented);
    fetchedHospital.locations[oldLocation].count =
        fetchedHospital.locations[oldLocation].count - 1;
    await updateHospital();
  }

  Future changeLocationInHospitalCount(
      String locationToBeIncremented, String locationToBeDecremented) async {
    var newLocation = fetchedHospital.locations
        .indexWhere((element) => element.id == locationToBeIncremented);

    fetchedHospital.locations[newLocation].count =
        fetchedHospital.locations[newLocation].count + 1;

    await updateHospital();
  }

  Future updateQuantity(medicalSupply item, int newQuantity) async {
    print(newQuantity.toString());
    var itemToUpdate = fetchedHospital.medicalSupplies
        .indexWhere((element) => element.id == item.id);
    fetchedHospital.medicalSupplies[itemToUpdate].qty = newQuantity;
    print(fetchedHospital.medicalSupplies[itemToUpdate].qty);
    await updateHospital();
  }

  getVentilatorCount() {
    return fetchedHospital.equipments[0].qty;
  }

  Future updateHospital() async {
    isUpdating = true;
    // updatingInFirebase = true;
    // finishedUpdatingFirebase = false;
    notifyListeners();

    await hospitalsCollection
        .document(fetchedHospital.id)
        .updateData(fetchedHospital.toMap());
    isUpdating = false;
    notifyListeners();
    // updatingInFirebase = false;
    // finishedUpdatingFirebase = true;
    // notifyListeners();
  }
}
