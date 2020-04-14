import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:provider/provider.dart';

import '../models/travelHistory.dart';
import '../widgets/patient_detailed_header.dart';

class PatientScreeningScreen extends StatefulWidget {
  @override
  _PatientScreeningScreenState createState() => _PatientScreeningScreenState();
}

class _PatientScreeningScreenState extends State<PatientScreeningScreen> {
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

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");

    Patient newPatient = Provider.of<Patients>(context).newPatient;

    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Card(
                child: Padding(
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
                      Expanded(
                        child: Container(
                          //     height: 300,
                          child: GridView.count(
                            childAspectRatio: (5 / 2),
                            mainAxisSpacing: 0,
                            crossAxisCount: 2,
                            children: <Widget>[
                              CheckboxListTile(
                                title: Text("Cough"),
                                value: symptomHasCough,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    symptomHasCough = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Fever"),
                                value: symptomHasFever,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    symptomHasFever = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Tiredness"),
                                value: symptomHasTiredness,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    symptomHasTiredness = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Difficulty Breathing"),
                                value: symptomHasDifficultyBreathing,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    symptomHasDifficultyBreathing = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
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
                    CheckboxListTile(
                      title: Text(
                          "Has the patient visited any other countries in the last 30 days?"),
                      value: hasTravelledAbroad,
                      onChanged: (bool value) {
                        print(value);
                        setState(() {
                          hasTravelledAbroad = value;
                        });
                      },
                    ),
                    hasTravelledAbroad == true
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
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
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300])),
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
                                      initialValue: DateTime.now(),
                                      format: format,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2019),
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            lastDate: DateTime(2021));
                                        setState(() {
                                          travelDetails.arrivalDate = date;
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
            ),

            /*   Form(
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                              'Has the patient travelled to any country in the last 30 days?'),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: new Checkbox(
                              value: hasTravelledAbroad,
                              onChanged: (value) {
                                setState(() {
                                  hasTravelledAbroad = value;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),*/
            SizedBox(height: 8.0),
            Flexible(
              flex: 5,
              child: Card(
                child: Padding(
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
                      Expanded(
                        child: Container(
                          //     height: 300,
                          child: GridView.count(
                            childAspectRatio: (5 / 2),
                            mainAxisSpacing: 0,
                            crossAxisCount: 2,
                            children: <Widget>[
                              CheckboxListTile(
                                title: Text("HyperTension"),
                                value: hasHyperTension,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasHyperTension = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Heart Disease"),
                                value: hasHeartDisease,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasHeartDisease = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Atrial Fibrilation"),
                                value: hasAtrialFibrilation,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasAtrialFibrilation = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Diabetes"),
                                value: hasDiabetes,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasDiabetes = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Active Cancer(last 5 yrs.)"),
                                value: hasActiveCancer,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasActiveCancer = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Chronic Kidney Disease"),
                                value: hasChronicKidneyDisease,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasChronicKidneyDisease = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("COPD"),
                                value: hasCOPD,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasCOPD = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Stroke"),
                                value: hasStroke,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasStroke = newValue;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Dementia"),
                                value: hasDementia,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hasDementia = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Spacer(),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.lightGreen,
                      child: Text(
                        "Home Quarantine",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      color: Colors.red[600],
                      child: Text(
                        "Move to Isolation",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
