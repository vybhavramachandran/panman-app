import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panman/utils/analytics_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  Future getHCWDetailsFromServerUsingAPI(String uidQuery) async {
    var hcwSnapshot;
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
   // print("userData+${userData}");
    var decodedJson= json.decode(userData);
    var token = decodedJson['token'];
    print("Fetched token is $token");
    try {
      print('getHCWDetails via API called');
      final response = await http.get(
          'https://us-central1-thewarroom-98e6d.cloudfunctions.net/app/healthcareworkers/uid/' +
              uidQuery,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          });
          print("HCW Response "+response.statusCode.toString());
      if (response.statusCode == 200) {
        hcwSnapshot = json.decode(response.body);
        print(hcwSnapshot.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load album');
      }

      hcwloggedin = HealthCareWorker(
          firstName: hcwSnapshot[0]['firstName'],
          lastName: hcwSnapshot[0]['lastName'],
          hospitalID: hcwSnapshot[0]['hospitalID'],
          role: hcwSnapshot[0]['role'],
          uid: hcwSnapshot[0]['uid']);
      notifyListeners();

      Analytics.instance.logEvent(
          name:
              "Fetched HCW details ${hcwloggedin.firstName}, ${hcwloggedin.lastName}, ${hcwloggedin.hospitalID}");
      print(
          "Fetched HCW details ${hcwloggedin.firstName}, ${hcwloggedin.lastName}, ${hcwloggedin.hospitalID}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
