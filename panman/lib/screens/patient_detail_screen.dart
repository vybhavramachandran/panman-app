import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:panman/models/event.dart';
import 'package:provider/provider.dart';

import '../models/arguments/patient_detail_arguments.dart';
import '../models/patient.dart';
import '../providers/patients.dart';
import '../widgets/patient_detailed_header.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient_detail_screen';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Patient localPatient;

  _refreshPatient() async {
    localPatient = await Provider.of<Patients>(context, listen: false)
        .fetchPatientDetailsFromAPI(localPatient.id);
  }

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

  Widget _eventWidget(
      {@required event event, @required bool isStart, @required bool isLast}) {
    return Container(
      height: 62.0,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(height: isStart ? 16.0 : 0.0),
              Container(
                height: isStart ? 0.0 : 40.0,
                width: 2.0,
                color: Color(0xFF8B8B8B),
              ),
              Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF8B8B8B),
                ),
              ),
              Container(
                height: isLast ? 0.0 : 40.0,
                width: 2.0,
                color: Color(0xFF8B8B8B),
              ),
            ],
          ),
          Container(
            height: 40.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO: i put fixed icon as i think icons should be included with event object
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(
                    'assets/images/isolation.svg',
                    height: 40.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat.yMMMMd().format(event.eventDateTime),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      event.eventType,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Icon(
            Icons.open_in_new,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  patientDetailScreenHome(Patient selectedPatient) {
    selectedPatient.events
        .sort((a, b) => b.eventDateTime.compareTo(a.eventDateTime));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 280.0,
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PATIENT HISTORY',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: selectedPatient.events
                              .map((e) => _eventWidget(
                                    event: e,
                                    isStart:
                                        selectedPatient.events.indexOf(e) == 0,
                                    isLast: selectedPatient.events.indexOf(e) ==
                                        (selectedPatient.events.length - 1),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
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
                      patientPageCard(
                        iconToDisplay: "assets/images/ventilator.png",
                        titleOfCard: "ASSIGN EQUIPMENT",
                        moveToPage: '/patient_detail_assign_equipment_screen',
                        // patient: selectedPatient,
                      ),
                    ],
                  ),
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
              "PATIENT",
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
