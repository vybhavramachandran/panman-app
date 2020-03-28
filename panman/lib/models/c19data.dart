import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum C19PatientState { AS1, AS2, S1, S2, S3, S4, S5 }

class c19 {
  C19PatientState state;
  String abbrv;
  String fullText;
  String info;
  Color stateColor;

  c19({this.state, this.abbrv, this.fullText, this.info, this.stateColor});
}

List<c19> c19states = [
  c19(
    state: C19PatientState.AS1,
    abbrv: "AS-1",
    fullText: "Asymptomatic - Without Comorbity",
    info: "TBD",
    stateColor: Colors.green,
  ),
  c19(
    state: C19PatientState.AS2,
    abbrv: "AS-2",
    fullText: "Asymptomatic - With Comorbity",
    info: "TBD",
    stateColor: Colors.lightGreen,
  ),
  c19(
    state: C19PatientState.S1,
    abbrv: "S-1",
    fullText: "Symptomatic/URTI - Without comorbity",
    info: "TBD",
    stateColor: Colors.yellow[200],
  ),
  c19(
    state: C19PatientState.S2,
    abbrv: "S-2",
    fullText: "Symptomatic/URTI - With comorbity",
    info: "TBD",
    stateColor: Colors.yellow,
  ),
  c19(
    state: C19PatientState.S3,
    abbrv: "S-3",
    fullText: "Symptomatic. Pneumonia. Without respiratory failure / MODS",
    info: "TBD",
    stateColor: Colors.orange[300],
  ),
  c19(
    state: C19PatientState.S4,
    abbrv: "S-4",
    fullText:
        "Symptomatic. Severe Pneumonia. Without respiratory failure / MODS",
    info: "TBD",
    stateColor: Colors.orange,
  ),
  c19(
    state: C19PatientState.S5,
    abbrv: "S-5",
    fullText: "Symptomatic. Severe Pneumonia. With respiratory failure / MODS",
    info: "TBD",
    stateColor: Colors.red,
  ),
];
