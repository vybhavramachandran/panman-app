import 'package:flutter/material.dart';

import '../models/healthcareworker.dart';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HealthCareWorkers with ChangeNotifier {
  HealthCareWorker hcwloggedin;

  Future getHCWDetailsFromServer(String uidQuery) async {
    print('getHCWDetails called');
    var hcwCollection = Firestore.instance.collection('healthcareworkers');
    var hcwSnapshot = await hcwCollection.document(uidQuery).get();
    hcwloggedin = HealthCareWorker(
        firstName: hcwSnapshot['firstName'],
        lastName: hcwSnapshot['lastName'],
        hospitalID: hcwSnapshot['hospitalID'],
        role: hcwSnapshot['role'],
        uid: hcwSnapshot['uid ']);
    notifyListeners();

    print(
        "Fetched HCW details ${hcwSnapshot['firstName']}, ${hcwSnapshot['lastName']}, ${hcwSnapshot['hospitalID']}");
    return true;
  }
}
