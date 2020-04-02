import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../models/locationInHospital.dart';

import '../providers/patients.dart';
import '../providers/hospital.dart';

import './state_box.dart';

class PatientDetailedHeader extends StatelessWidget {
  Patient headerPatient;
  Color textColor;

  PatientDetailedHeader({this.headerPatient, this.textColor});

  List localListOfLocations = [
    "Home Quarantine",
    "Registration Counter",
    "Screening Section",
    "C19 Suspected Isolation",
    "C19 Confirmed Isolation",
    "ICU",
  ];
  @override
  Widget build(BuildContext context) {
    Patient newPatient =
        Provider.of<Patients>(context, listen: true).selectedPatient;

    String fullname = newPatient.Firstname + " " + newPatient.LastName;

    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 0, left: 20),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  fullname,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        newPatient.sex == Sex.Male
                            ? FaIcon(
                                FontAwesomeIcons.mars,
                                size: 15,
                                color: Colors.white,
                              )
                            : FaIcon(
                                FontAwesomeIcons.female,
                                size: 15,
                                color: Colors.white,
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        newPatient.sex == Sex.Male
                            ? Text("MALE", style: TextStyle(color: textColor))
                            : Text("FEMALE",
                                style: TextStyle(color: textColor)),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("32 YEARS", style: TextStyle(color: textColor)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.procedures,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(localListOfLocations[newPatient.currentLocation],
                        style: TextStyle(color: textColor)),
                  ],
                ),
              ],
            ),
            Provider.of<Patients>(context, listen: true)
                        .selectedPatient
                        .currentLocation >
                    2
                ? C19StateBox(
                    patientState: Provider.of<Patients>(context, listen: true)
                        .selectedPatient
                        .state,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
