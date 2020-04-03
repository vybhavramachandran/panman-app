import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum C19PatientState { AS1, AS2, S1, S2, S3, S4, S5 }


  List<c19> referenceCovid19SeverityLevelsList = [
    c19(
        isSymptomatic: false,
        index: 0,
        abbrv: "NP-1",
        fullText: "Not Tested / Uknown",
        info: "Patient has not been tested. Status unknown",
        stateColor: Colors.grey),
    c19(
        isSymptomatic: false,
        index: 1,
        abbrv: "NP-2",
        fullText: "Tested. Negative Result.",
        info: "Patient tested. Confirmed Negative",
        stateColor: Colors.black54),
    c19(
        isSymptomatic: false,
        index: 2,
        abbrv: "AS-1",
        fullText: "Asymptomatic - Without Comorbity",
        info: "TBD",
        stateColor: Colors.green),
    c19(
        isSymptomatic: false,
        index: 3,
        abbrv: "AS-2",
        fullText: "Asymptomatic - With Comorbityn",
        info: "TBD",
        stateColor: Colors.greenAccent),
    c19(
        isSymptomatic: true,
        index: 4,
        abbrv: "S-1",
        fullText: "Symptomatic/URTI - Without comorbity",
        info: "TBD",
        stateColor: Colors.orange),
    c19(
        isSymptomatic: true,
        index: 5,
        abbrv: "S-2",
        fullText: "Symptomatic/URTI - With comorbity",
        info: "TBD",
        stateColor: Colors.red[200]),
    c19(
        isSymptomatic: true,
        index: 6,
        abbrv: "S-3",
        fullText: "Symptomatic. Pneumonia. Without respiratory failure / MODS",
        info: "TBD",
        stateColor: Colors.red[300]),
    c19(
        isSymptomatic: true,
        index: 7,
        abbrv: "S-4",
        fullText:
            "Symptomatic. Severe Pneumonia. Without respiratory failure / MODS",
        info: "TBD",
        stateColor:Colors.red[400]),
    c19(
        isSymptomatic: true,
        index: 8,
        abbrv: "S-5",
        fullText:
            "Symptomatic. Severe Pneumonia. With respiratory failure / MODS",
        info: "TBD",
        stateColor: Colors.red,),
    c19(
        isSymptomatic: true,
        index: 9,
        abbrv: "S-6",
        fullText:
            "Deceased",
        info: "TBD",
        stateColor: Colors.black,),
  ];


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

class c19 {
  bool isSymptomatic;
  String state;
  String abbrv;
  String fullText;
  String info;
  Color stateColor;
  int index;

  c19({this.isSymptomatic, this.state, this.abbrv, this.fullText, this.info, this.stateColor, this.index});
}
