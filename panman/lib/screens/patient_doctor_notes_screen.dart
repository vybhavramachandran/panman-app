import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:panman/models/patientVital.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

import '../widgets/patient_detailed_header.dart';
import '../widgets/timeline.dart';

import '../models/patient.dart';
import '../models/patientNote.dart';

import '../providers/patients.dart';

class PatientDoctorNotesScreen extends StatefulWidget {
  static const routeName = '/patient_doctor_notes_screen';
  @override
  _PatientDoctorNotesScreenState createState() =>
      _PatientDoctorNotesScreenState();
}

class _PatientDoctorNotesScreenState extends State<PatientDoctorNotesScreen> {
  Widget getNoteCard(PatientNote noteToDisplay) {
    var mappedNote = noteToDisplay.toMap();
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat.jm().add_yMd().format(noteToDisplay.timestamp),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.black, fontWeight: FontWeight.w200),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //     color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mappedNote.entries.map((e) {
                  var fetchedKey = noteToDisplay.getDisplayName(e.key);

                  if (e.key == 'id' || e.key == 'timestamp') {
                    return Container();
                  } else {
                    if (e.value == "") {
                      return Container();
                    } else if (e.value.toString().contains("{")) {
                      // var split_value = e.value.toString().split(",")[0].split(":")[1];
                      // print(e.value.toString().split(",")[0]);
                      // print(e.value.toString().split(",")[0].split(":")[1]);
                      var keyToDisplay = Text(
                        e.key.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Theme.of(context).accentColor),
                      );
                      return Text(
                          "$fetchedKey : ${e.value.toString().split(",")[0].split(":")[1]}");
                    } else
                      return Text("$fetchedKey : ${e.value}");
                  }
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            "PATIENT / DOCTOR NOTES",
            style: Theme.of(context).textTheme.caption,
          ),
          centerTitle: true,
          flexibleSpace: PatientDetailedHeader(
            textColor: Colors.white,
            headerPatient:
                Provider.of<Patients>(context, listen: true).selectedPatient,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 10,
            child: Timeline(
              children: Provider.of<Patients>(context, listen: true)
                  .selectedPatient
                  .notes
                  .map((e) => getNoteCard(e))
                  .toList(),
              indicators: Provider.of<Patients>(context, listen: true)
                  .selectedPatient
                  .notes
                  .map((e) => Icon(Icons.access_alarm))
                  .toList(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/patient_doctor_notes_add_screen");
        },
        icon: Icon(Icons.add),
        label: Text("Add Note"),
      ),
    ));
  }
}
