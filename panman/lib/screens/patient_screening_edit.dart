import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:panman/screens/patient_contact_tracing.dart';
import 'package:panman/screens/patient_recommendation_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:convert';

import '../widgets/patient_detailed_header.dart';
import '../models/screening.dart';
import '../models/travelHistory.dart';

class EditPatientScreeningScreen extends StatefulWidget {
  static const routeName = '/patient_screening_page_edit';

  @override
  _EditPatientScreeningScreenState createState() => _EditPatientScreeningScreenState();
}

class _EditPatientScreeningScreenState extends State<EditPatientScreeningScreen> {
  // _proceed(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (BuildContext context) => PatientRecommendationScreen()));
  // }

  bool hasTravelledAbroad = false;
  TravelHistory travelDetails = TravelHistory();
  bool hasHyperTension = false;
  bool hasHeartDisease = false;
  bool hasAtrialFibrilation = false;
  bool hasDiabetes = false;
  bool hasActiveCancer = false;
  bool hasChronicKidneyDisease = false;
  bool hasCOPD = false;
  bool hasStroke = false;
  bool hasDementia = false;

  bool symptomHasCough = false;
  bool symptomHasFever = false;
  bool symptomHasTiredness = false;
  bool symptomHasDifficultyBreathing = false;

  Screening screeningResult = new Screening(
    hasComorbdityOrganTransplant: false,
    hasComorbidityCOPD: false,
    hasComorbidityChronicNeuro: false,
    hasComorbidityChronicRenalDisease: false,
    hasComorbidityDiabetes: false,
    hasComorbidityHIV: false,
    hasComorbidityHeartDisease: false,
    hasComorbidityHypertension: false,
    hasComorbidityLiverDisease: false,
    hasComorbidityMalignancy: false,
    hasComorbidityPregnancy: false,
    hasCough: false,
    hasDifficultyBreathing: false,
    hasFever: false,
    hasTravelledAboard: false,
    hasTiredness: false,
    returnDate: DateTime.now(),
    visitedCountry: "No Data",
  );

  // saveScreeningAndQuarantine() async {
  //   print("saveScreeningAndQuarantine called");

  //   //print(json.encode(screeningResult));

  //   await Provider.of<Patients>(context, listen: false)
  //       .addScreening(screeningResult, 0);
  //   Navigator.of(context).pop(true);
  // }

  saveScreening() async {
    print("saveScreeningCalled called");

    await Provider.of<Patients>(context, listen: false)
        .editScreening(screeningResult);
    Navigator.of(context).pop();
  }

  saveScreeningAndIsolate() async {
    print("saveScreeningAndMoveToIsolationCalled called");

    await Provider.of<Patients>(context, listen: false)
        .addScreening(screeningResult, 3);
    Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PatientContactTracingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");

    Patient newPatient = Provider.of<Patients>(context).newPatient;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "PATIENT / SCREENING",
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 20,
                  child: SingleChildScrollView(
                                      child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("Symptoms",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.black))),
                              Container(
                                height: 150,
                                child: GridView.count(
                                  childAspectRatio: (5 / 2),
                                  mainAxisSpacing: 0,
                                  crossAxisCount: 2,
                                  children: <Widget>[
                                    CheckboxListTile(
                                      title: Text("Cough"),
                                      value: screeningResult.hasCough,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasCough = newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Fever"),
                                      value: screeningResult.hasFever,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasFever = newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Tiredness"),
                                      value: screeningResult.hasTiredness,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasTiredness = newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Difficulty Breathing"),
                                      value:
                                          screeningResult.hasDifficultyBreathing,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasDifficultyBreathing =
                                              newValue;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("Travel History",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.black))),
                              SizedBox(height: 30),
                              CheckboxListTile(
                                title: Text(
                                    "Has the patient visited any other countries in the last 30 days?"),
                                value: screeningResult.hasTravelledAboard,
                                onChanged: (bool value) {
                                  print(value);
                                  setState(() {
                                    screeningResult.hasTravelledAboard = value;
                                  });
                                },
                              ),
                              screeningResult.hasTravelledAboard == true
                                  ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 5,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    screeningResult
                                                        .visitedCountry = value;
                                                  });
                                                },
                                                keyboardType: TextInputType.text,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Enter valid country name';
                                                  }
                                                  return null;
                                                },
                                                //  style: Theme.of(context).textTheme.bodyText1,
                                                decoration: InputDecoration(
                                                  labelText: "Country Name",
                                                  // hintText: "Event",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[300])),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[300])),
                                                ),
                                                onSaved: (String value) {},
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              flex: 5,
                                              child: DateTimeField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    screeningResult.returnDate =
                                                        value;
                                                  });
                                                },
                                                initialValue: DateTime.now(),
                                                format: format,
                                                onShowPicker: (context,
                                                    currentValue) async {
                                                  final date =
                                                      await showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(2019),
                                                          initialDate:
                                                              currentValue ??
                                                                  DateTime.now(),
                                                          lastDate:
                                                              DateTime(2021));
                                                  setState(() {
                                                    travelDetails.arrivalDate =
                                                        date;
                                                  });
                                                  return date;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("Comorbidities",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.black))),
                              SizedBox(height:30),
                              Container(
                              //  height: 700,
                                child: Column(
                                  // shrinkWrap: true,
                                  // childAspectRatio: (3 / 2),
                                  // //   mainAxisSpacing: 1,
                                  // crossAxisCount: 2,
                                  children: <Widget>[
                                    CheckboxListTile(
                                      title: Text("COPD, Bronchitis, or Asthma"),
                                      value: screeningResult.hasComorbidityCOPD,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasComorbidityCOPD =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Chronic Renal Disease"),
                                      value: screeningResult
                                          .hasComorbidityChronicRenalDisease,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbidityChronicRenalDisease =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Malignancy"),
                                      value: screeningResult
                                          .hasComorbidityMalignancy,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbidityMalignancy =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Diabetes"),
                                      value:
                                          screeningResult.hasComorbidityDiabetes,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasComorbidityDiabetes =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Hypertension"),
                                      value: screeningResult
                                          .hasComorbidityHypertension,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbidityHypertension =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "Pregnancy (trimester) or Post-partum (<6 weeks)"),
                                      value:
                                          screeningResult.hasComorbidityPregnancy,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                              .hasComorbidityPregnancy = newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Liver Disease"),
                                      value: screeningResult
                                          .hasComorbidityLiverDisease,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbidityLiverDisease =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "Chronic neurological or neuromuscular disease "),
                                      value: screeningResult
                                          .hasComorbidityChronicNeuro,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbidityChronicNeuro =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "Immune Compromised/Suspressed including HIV/TB"),
                                      value: screeningResult.hasComorbidityHIV,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult.hasComorbidityHIV =
                                              newValue;
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("Organ transplant patient"),
                                      value: screeningResult
                                          .hasComorbdityOrganTransplant,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          screeningResult
                                                  .hasComorbdityOrganTransplant =
                                              newValue;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            //width: (MediaQuery.of(context).size.width - 50) / 2,
                            child: FlatButton(
                              onPressed: () async {
                                saveScreeningAndIsolate();
                              },
                              color: Theme.of(context).accentColor,
                              child:
                                  Provider.of<Patients>(context, listen: true)
                                              .isAddingPatient ==
                                          false
                                      ? Text("SAVE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith())
                                      : CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        ),
                            ),
                          ),

                          
                          // FlatButton(
                          //   onPressed: () async {
                          //     await savePatientAndGoToScreening();
                          //   },
                          //   color: Theme.of(context).accentColor,
                          //   child: Text("START SCREENING",
                          //       style: Theme.of(context).textTheme.caption),
                          // ),

                          
                        ],
                      ),
                    ),
                  ),
                ),

                //Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
