import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/patient_detailed_header.dart';

import '../models/locationInHospital.dart';

import '../providers/patients.dart';
import '../providers/hospital.dart';

class PatientDetailMoveScreen extends StatefulWidget {
  static const routeName = '/patient_detail_move_screen';

  @override
  _PatientDetailMoveScreenState createState() =>
      _PatientDetailMoveScreenState();
}

class _PatientDetailMoveScreenState extends State<PatientDetailMoveScreen> {
  //radio options

  bool setOnce = false;
  int selectedRadio;
  bool showConfirmButton = false;
  radioOnTapped(int value) {
    setState(() {
      showConfirmButton = true;

      selectedRadio = value;
    });
  }

  //

  localtionInHospitalCard(
      {String abbrv, String fullText, Color cardColor, int optionNo}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Container(
              //   width: 15,
              //   color: cardColor,
              // ),
              Flexible(
                flex: 1,
                child: Radio(
                  value: optionNo,
                  groupValue: selectedRadio,
                  onChanged: (value) => radioOnTapped(value),
                ),
              ),
              // Flexible(
              //   flex: 2,
              //   child: Text(
              //     abbrv,
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline5
              //         .copyWith(color: Colors.black),
              //   ),
              // ),
              Flexible(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    fullText,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: FaIcon(
                  FontAwesomeIcons.infoCircle,
                  size: 15,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (setOnce == false) {
      this.selectedRadio = Provider.of<Patients>(context, listen: true)
              .selectedPatient
              .currentLocation +
          1;
      setOnce = true;
    }
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                "PATIENT / MOVE",
                style: Theme.of(context).textTheme.caption,
              ),
              centerTitle: true,
              flexibleSpace: PatientDetailedHeader(
                textColor: Colors.white,
                headerPatient: Provider.of<Patients>(context, listen: true)
                    .selectedPatient,
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Home",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  localtionInHospitalCard(
                    fullText: "Home Quarantine",
                    cardColor: Colors.green,
                    optionNo: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "In hospital",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  localtionInHospitalCard(
                    fullText: "Registration",
                    cardColor: Colors.lightGreen,
                    optionNo: 2,
                  ),
                  localtionInHospitalCard(
                    fullText: "Screening",
                    cardColor: Colors.lightGreen,
                    optionNo: 3,
                  ),
                  localtionInHospitalCard(
                    fullText: "Suspected C19 Isolation Ward/Holding area",
                    cardColor: Colors.lightGreen,
                    optionNo: 4,
                  ),
                  localtionInHospitalCard(
                    fullText: "Confirmed C19 Isolation Ward",
                    cardColor: Colors.lightGreen,
                    optionNo: 5,
                  ),
                  localtionInHospitalCard(
                    fullText: "ICU",
                    cardColor: Colors.lightGreen,
                    optionNo: 6,
                  ),
                ],
              ),
              showConfirmButton == true
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          child: Provider.of<Patients>(context, listen: true)
                                  .isUpdating
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white30,
                                )
                              : Text(
                                  "MOVE PATIENT",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                          onPressed: () async {
                            var oldState =
                                Provider.of<Patients>(context, listen: false)
                                    .selectedPatient
                                    .currentLocation;
                            var newState = selectedRadio - 1;
                            if (await Provider.of<Patients>(context,
                                        listen: false)
                                    .movePatient(selectedRadio - 1) ==
                                true) {
                              await Provider.of<Hospitals>(context,
                                      listen: false)
                                  .changeLocationInHospitalCount(
                                      Provider.of<Hospitals>(context,listen:false).referenceHospitalLocationList[newState].id,
                                      Provider.of<Hospitals>(context,listen:false).referenceHospitalLocationList[oldState].id);
                              setState(() {
                                showConfirmButton = false;
                              });
                              return;
                            }
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
