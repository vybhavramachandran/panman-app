import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panman/utils/analytics_client.dart';

import '../models/healthcareworker.dart';

class HealthCareWorkers with ChangeNotifier {
  HealthCareWorker hcwloggedin;

  Future logoutHCW() {
    hcwloggedin = null;
    notifyListeners();
  }

  Future getHCWDetailsFromServer(String uidQuery) async {
    try {
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

      Analytics.instance.logEvent(
          name:
              "Fetched HCW details ${hcwSnapshot['firstName']}, ${hcwSnapshot['lastName']}, ${hcwSnapshot['hospitalID']}");
      print(
          "Fetched HCW details ${hcwSnapshot['firstName']}, ${hcwSnapshot['lastName']}, ${hcwSnapshot['hospitalID']}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
