import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/hospital.dart';
import '../models/medicalSupply.dart';

import '../models/patient.dart';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hospitals with ChangeNotifier {
  var hospitalsCollection = Firestore.instance.collection('hospitals');
  var hospitalSnapshot;

  Hospital fetchedHospital = Hospital(hospitalName: "loading..");

  bool isUpdating = false;

  Future getHospitalDetailsFromServer(String hospitalID) async {
    hospitalSnapshot = await hospitalsCollection.document(hospitalID).get();
    fetchedHospital = Hospital.fromMap(hospitalSnapshot.data);
    notifyListeners();
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
