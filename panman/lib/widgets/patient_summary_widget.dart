import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../providers/hospital.dart';

import '../models/patient.dart';
import '../models/arguments/patient_detail_arguments.dart';

import './state_box.dart';

import '../screens/patient_detail_screen.dart';

class PatientSummaryWidget extends StatelessWidget {
  Patient patient;

  PatientSummaryWidget({this.patient});

  @override
  Widget build(BuildContext context) {
    String fullname = patient.Firstname + " " + patient.LastName;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: () {
          Provider.of<Patients>(context, listen: false)
              .selectPatient(patient.id);
          return Navigator.pushNamed(context, PatientDetailScreen.routeName,
              arguments: PatientDetailArguments(patient));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      fullname,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            patient.sex == Sex.Male
                                ? FaIcon(
                                    FontAwesomeIcons.mars,
                                    size: 15,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.female,
                                    size: 15,
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            patient.sex == Sex.Male
                                ? Text("MALE")
                                : Text("FEMALE"),
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
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(patient.age.toString() + " YEARS"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.procedures,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width:200,
                          child: Text(Provider.of<Hospitals>(context, listen: true)
                              .referenceHospitalLocationList[
                                  patient.currentLocation]
                              .name),
                        ),
                      ],
                    ),
                  ],
                ),
               patient.currentLocation!=1?C19StateBox(
                  patientState: patient.state,
                ):Container(),
                FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
