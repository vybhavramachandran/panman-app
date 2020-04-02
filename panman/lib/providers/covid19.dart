import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/medicalSupply.dart';

import '../models/patient.dart';
import '../models/c19data.dart';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Covid19 with ChangeNotifier {
/*  List<c19> referenceCovid19SeverityLevelsList = [
    c19(
        isSymptomatic: false,
        index: 0,
        abbrv: "NP-1",
        fullText: "Not Tested / Uknown",
        info: "Patient has not been tested. Status unknown",
        stateColor: HexColor("000603")),
    c19(
        isSymptomatic: false,
        index: 1,
        abbrv: "NP-2",
        fullText: "Tested. Negative Result.",
        info: "Patient tested. Confirmed Negative",
        stateColor: HexColor("530EF3")),
    c19(
        isSymptomatic: false,
        index: 2,
        abbrv: "AS-1",
        fullText: "Asymptomatic - Without Comorbity",
        info: "TBD",
        stateColor: HexColor("008000")),
    c19(
        isSymptomatic: false,
        index: 3,
        abbrv: "AS-2",
        fullText: "Asymptomatic - With Comorbityn",
        info: "TBD",
        stateColor: HexColor("00FF00")),
    c19(
        isSymptomatic: true,
        index: 4,
        abbrv: "S-1",
        fullText: "Symptomatic/URTI - Without comorbity",
        info: "TBD",
        stateColor: HexColor("E9967A")),
    c19(
        isSymptomatic: true,
        index: 5,
        abbrv: "S-2",
        fullText: "Symptomatic/URTI - With comorbity",
        info: "TBD",
        stateColor: HexColor("CD5C5C")),
    c19(
        isSymptomatic: true,
        index: 6,
        abbrv: "S-3",
        fullText: "Symptomatic. Pneumonia. Without respiratory failure / MODS",
        info: "TBD",
        stateColor: HexColor("DC143C")),
    c19(
        isSymptomatic: true,
        index: 7,
        abbrv: "S-4",
        fullText:
            "Symptomatic. Severe Pneumonia. Without respiratory failure / MODS",
        info: "TBD",
        stateColor: HexColor("8B0000")),
    c19(
        isSymptomatic: true,
        index: 8,
        abbrv: "S-5",
        fullText:
            "Symptomatic. Severe Pneumonia. With respiratory failure / MODS",
        info: "TBD",
        stateColor: HexColor("FF4500")),
  ];

  Future getReferenceCovid19SevererityLevels() async {
    referenceCovid19SeverityLevelsList.clear();
    var referenceCovid19SeverityLevelsCollection =
        Firestore.instance.collection('covid19severitylevels');

    var newList = await referenceCovid19SeverityLevelsCollection.getDocuments();

    newList.documents.forEach((element) {
      print(element['fullText']);
      referenceCovid19SeverityLevelsList.add(c19(
        isSymptomatic: element['symptomatic'],
        abbrv: element['abbreviation'],
        fullText: element['fullText'],
        info: element['info'],
        stateColor: HexColor(element['stateColorInHex']),
        index: element['index'],
      ));
    });

    notifyListeners();
  }*/
}
