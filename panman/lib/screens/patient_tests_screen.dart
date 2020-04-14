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
import '../models/test.dart';

import '../providers/patients.dart';

class PatientTestsScreen extends StatefulWidget {
  static const routeName = '/patient_tests_screen';
  @override
  _PatientTestsScreenScreenState createState() =>
      _PatientTestsScreenScreenState();
}

class _PatientTestsScreenScreenState extends State<PatientTestsScreen> {
  Widget getTestCard(Test testToDisplay) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //     color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("id : ${testToDisplay.id}"),
                  Text(
                      "Result Date : ${DateFormat.yMd().format(testToDisplay.resultDate)}"),
                  Text("Testing Centre : ${testToDisplay.testCenterName}"),
                  Text("Result : ${testToDisplay.result}"),
                ],
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
            "PATIENT/TESTS",
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
                  .tests
                  .map((e) => getTestCard(e))
                  .toList(),
              indicators: Provider.of<Patients>(context, listen: true)
                  .selectedPatient
                  .tests
                  .map((e) => Icon(Icons.access_alarm))
                  .toList(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/add_test_screen");
        },
        icon: Icon(Icons.add),
        label: Text("Add a Test result"),
      ),
    ));
  }
}
