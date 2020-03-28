import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class locationInHospital {
  int levelNumber;
  String abbreviation;
  String fullLevelName;
  
  locationInHospital({this.levelNumber, this.abbreviation, this.fullLevelName});
}

List<locationInHospital> locations = [
  locationInHospital(
    levelNumber: 0,
    abbreviation: "Home Quarantine",
    fullLevelName: "Home Quarantine",
  ),
  locationInHospital(
    levelNumber: 1,
    abbreviation: "Reg.",
    fullLevelName: "Registration Counter",
  ),
  locationInHospital(
    levelNumber: 2,
    abbreviation: "Screen.",
    fullLevelName: "Screening section",
  ),
  locationInHospital(
    levelNumber: 3,
    abbreviation: "Sus. Isolation.",
    fullLevelName: "C19 Suspect Isolation",
  ),
  locationInHospital(
    levelNumber: 4,
    abbreviation: "C19+ Isolation.",
    fullLevelName: "C19 Confirmed Isolation",
  ),
  locationInHospital(
    levelNumber: 5,
    abbreviation: "ICU",
    fullLevelName: "ICU",
  ),
];
