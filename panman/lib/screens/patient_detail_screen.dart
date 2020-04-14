import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/arguments/patient_detail_arguments.dart';

import '../widgets/patient_detailed_header.dart';
import '../widgets/timeline.dart';
import '../screens/patient_detail_cov19_screen.dart';
import '../providers/patients.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient_detail_screen';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Patient localPatient;

  // _refreshPatient() async {
  //   localPatient = await Provider.of<Patients>(context, listen: false)
  //       .fetchPatientDetailsFromAPI(localPatient.id);
  // }

  patientPageCard(
      {String moveToPage, String iconToDisplay, String titleOfCard}) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, moveToPage,
              arguments: PatientDetailArguments(localPatient));
          // .then((isChanged) => isChanged ? _refreshPatient():"");
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white30,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Image.asset(iconToDisplay),
                ),
                SizedBox(
                  height: 10,
                ),
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Container(
                    child: Center(
                      child: Text(titleOfCard,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  patientDetailScreenHome(Patient selectedPatient) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          // Flexible(
          //   flex: 2,
          //   child: SingleChildScrollView(
          //     child: Container(
          //       child: Timeline(
          //         children: <Widget>[
          //           Container(height: 100, color: Colors.red),
          //           Container(height: 50, color: Colors.blue),
          //           Container(height: 200, color: Colors.green),
          //           Container(height: 100, color: Colors.yellow),
          //           Container(height: 200, color: Colors.green),
          //           Container(height: 100, color: Colors.yellow),
          //           Container(height: 200, color: Colors.green),
          //           Container(height: 100, color: Colors.yellow),
          //           Container(height: 200, color: Colors.green),
          //           Container(height: 100, color: Colors.yellow),

          //         ],
          //         indicators: <Widget>[
          //           Icon(Icons.access_alarm),
          //           Icon(Icons.backup),
          //           Icon(Icons.accessibility_new),
          //           Icon(Icons.access_alarm),
          //           Icon(Icons.accessibility_new),
          //           Icon(Icons.access_alarm),
          //           Icon(Icons.accessibility_new),
          //           Icon(Icons.access_alarm),
          //           Icon(Icons.accessibility_new),
          //           Icon(Icons.access_alarm),

          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Flexible(
            flex: 2,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                patientPageCard(
                  iconToDisplay: "assets/images/monitor.png",
                  titleOfCard: "PATIENT VITALS",
                  moveToPage: "/patient_vitals_screen",

                  //  patient: selectedPatient,
                ),
                patientPageCard(
                  iconToDisplay: "assets/images/virus.png",
                  titleOfCard: "PATIENT COVID CATEGORY",
                  moveToPage: "/patient_detail_cov19_screen",
                  // patient: selectedPatient,
                ),
                patientPageCard(
                  iconToDisplay: "assets/images/move.png",
                  titleOfCard: "MOVE PATIENT",
                  moveToPage: "/patient_detail_move_screen",

                  // patient: selectedPatient,
                ),
                // patientPageCard(
                //   iconToDisplay: "assets/images/ventilator.png",
                //   titleOfCard: "ASSIGN EQUIPMENT",
                //   moveToPage: '/patient_detail_assign_equipment_screen',
                //   // patient: selectedPatient,
                // ),
                patientPageCard(
                  iconToDisplay: "assets/images/laboratory.png",
                  titleOfCard: "TESTS",
                  moveToPage: "/patient_tests_screen",

                  //  patient: selectedPatient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PatientDetailArguments args = ModalRoute.of(context).settings.arguments;

    setState(() {
      localPatient = args.currentPatient;
    });

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "PATIENT / DETAIL",
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
        body: patientDetailScreenHome(
            Provider.of<Patients>(context, listen: true).selectedPatient),
      ),
    );
  }
}
