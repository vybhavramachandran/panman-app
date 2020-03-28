import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/c19data.dart';

import '../providers/patients.dart';

import '../models/patient.dart';
import '../models/arguments/patient_detail_arguments.dart';

import '../widgets/patient_detailed_header.dart';

class PatientDetailCov19Screen extends StatefulWidget {
  static const routeName = '/patient_detail_cov19_screen';

  @override
  _PatientDetailCov19ScreenState createState() =>
      _PatientDetailCov19ScreenState();
}

class _PatientDetailCov19ScreenState extends State<PatientDetailCov19Screen> {
  // Radio controls
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
  Patient localPatient;

  c19card({String abbrv, String fullText, Color cardColor, int optionNo}) {
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
              Container(
                width: 15,
                color: cardColor,
              ),
              Flexible(
                flex: 1,
                child: Radio(
                  value: optionNo,
                  groupValue: selectedRadio,
                  onChanged: (value) => radioOnTapped(value),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  abbrv,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  fullText,
                  style: Theme.of(context).textTheme.bodyText2,
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
    // PatientDetailArguments args = ModalRoute.of(context).settings.arguments;
    if (setOnce == false) {
      this.selectedRadio = Provider.of<Patients>(context, listen: true)
              .selectedPatient
              .state
              .state
              .index +
          1;
      setOnce = true;
    }
    // setState(() {
    //   this.localPatient = args.currentPatient;
    // });
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                "PATIENT / STATUS",
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
                      "Asymptomatic",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  c19card(
                    abbrv: "AS-1",
                    fullText: "Asymptomatic - Without Comorbity",
                    cardColor: Colors.green,
                    optionNo: 1,
                  ),
                  c19card(
                    abbrv: "AS-2",
                    fullText: "Asymptomatic - With Comorbity",
                    cardColor: Colors.lightGreen,
                    optionNo: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Symptomatic",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  c19card(
                    abbrv: "S-1",
                    fullText: "Symptomatic/URTI - Without comorbity",
                    cardColor: Colors.yellow[200],
                    optionNo: 3,
                  ),
                  c19card(
                    abbrv: "S-2",
                    fullText: "Symptomatic/URTI - With comorbity",
                    cardColor: Colors.yellow,
                    optionNo: 4,
                  ),
                  c19card(
                    abbrv: "S-3",
                    fullText:
                        "Symptomatic. Pneumonia. Without respiratory failure / MODS",
                    cardColor: Colors.orange,
                    optionNo: 5,
                  ),
                  c19card(
                    abbrv: "S-4",
                    fullText:
                        "Symptomatic. Severe Pneumonia. Without respiratory failure / MODS",
                    cardColor: Colors.red[200],
                    optionNo: 6,
                  ),
                  c19card(
                      abbrv: "S-5",
                      fullText:
                          "Symptomatic. Severe Pneumonia. With respiratory failure / MODS",
                      cardColor: Colors.red,
                      optionNo: 7),
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
                              ? CircularProgressIndicator(backgroundColor: Colors.white30,)
                              : Text(
                                  "CHANGE STATE",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                          onPressed: () {
                            if (Provider.of<Patients>(context, listen: false)
                                    .changePatientState(C19PatientState
                                        .values[selectedRadio - 1]) ==
                                true) {
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
