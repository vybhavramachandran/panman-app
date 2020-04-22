import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/providers/covid19.dart';
import 'package:provider/provider.dart';
import '../models/c19data.dart';

import '../providers/patients.dart';
import '../providers/covid19.dart';

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
  String selectedAbbrv;
  bool showConfirmButton = false;

  radioOnTapped(int value, String abbrv) {
    print("radioOnTapped $value $abbrv");
    setState(() {
      showConfirmButton = true;
      selectedRadio = value;
      selectedAbbrv = abbrv;
    });
    print("radioOnTapped state $selectedRadio $selectedAbbrv");
  }

  //
  Patient localPatient;

  c19card({String abbrv, String fullText, Color cardColor, int optionNo}) {
    return GestureDetector(
      onTap: () {
        print("Gesture Detector called $optionNo $abbrv");
        radioOnTapped(optionNo, abbrv);
      },
      child: Card(
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
                Container(
                  child: Expanded(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Container(
                            child: Radio(
                              value: optionNo,
                              groupValue: selectedRadio,
                              onChanged: (value) => radioOnTapped(value, abbrv),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Container(
                            child: Text(
                              abbrv,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: Container(
                            child: Text(
                              fullText,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Container(
                            child: FaIcon(
                              FontAwesomeIcons.infoCircle,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getListOfCards() {
    var list = Provider.of<Covid19>(context, listen: true)
        .referenceCovid19SeverityLevelsList
        .map<Widget>(
      (c19 e) {
        if (e.index > 1) {
          print(e.index);
          return c19card(
            abbrv: e.abbrv,
            fullText: e.fullText,
            cardColor: e.stateColor,
            optionNo: e.index,
          );
        }
        return Container();
      },
    ).toList();
    list.add(SizedBox(height: 100));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // PatientDetailArguments args = ModalRoute.of(context).settings.arguments;

    if (setOnce == false) {
      if (Provider.of<Covid19>(context, listen: true)
              .referenceCovid19SeverityLevelsList
              .firstWhere((element) =>
                  element.abbrv ==
                  Provider.of<Patients>(context, listen: true)
                      .selectedPatient
                      .covidStatusString)
              .index <=
          1) {
        this.selectedRadio = 0;
      } else {
        this.selectedRadio = Provider.of<Covid19>(context, listen: true)
            .referenceCovid19SeverityLevelsList
            .firstWhere((element) =>
                element.abbrv ==
                Provider.of<Patients>(context, listen: true)
                    .selectedPatient
                    .covidStatusString)
            .index;
      }
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
              SingleChildScrollView(
                child: Column(
                  children: getListOfCards(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child:
                        Provider.of<Patients>(context, listen: true).isUpdating
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white30,
                              )
                            : Text(
                                "CHANGE STATE",
                                style: Theme.of(context).textTheme.caption,
                              ),
                    onPressed: () async {
                      if (await Provider.of<Patients>(context, listen: false)
                              .changePatientState(selectedAbbrv) ==
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
            ],
          )),
    );
  }
}
