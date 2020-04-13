import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:panman/screens/patient_recommendation_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:convert';

import '../widgets/patient_detailed_header.dart';
import '../models/screening.dart';
import '../models/travelHistory.dart';
import '../models/contactTracing.dart';

class PatientContactTracingScreen extends StatefulWidget {
  static const routeName = '/patient_contact_tracing';

  @override
  _PatientContactTracingScreenState createState() =>
      _PatientContactTracingScreenState();
}

class _PatientContactTracingScreenState
    extends State<PatientContactTracingScreen> {
  // _proceed(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (BuildContext context) => PatientRecommendationScreen()));
  // }

  contactTracing newContact = contactTracing(
    isMorePatientInfoAvailable: false,
    sourceOfInfection: "",
    sourcePatientAddress: "",
    sourcePatientFirstName: "",
    sourcePatientLastName: "",
  );

  submitTrackingAndMoveToState(int location) async {
    print("submitTrackingAndMoveToHome called");

    //print(json.encode(screeningResult));

    await Provider.of<Patients>(context, listen: false)
        .addContactTracking(newContact, location);
    Navigator.of(context).pushReplacementNamed('/home_screen');
  }

  typeOfContactChosen(String value) {
    setState(() {
      newContact.sourceOfInfection = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              "PATIENT / CONTACT TRACING",
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text("Source of Infection",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: "Foreign Travel",
                                    groupValue: newContact.sourceOfInfection,
                                    onChanged: (value) =>
                                        typeOfContactChosen(value),
                                  ),
                                  Text("Foreign Travel"),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: "Contact with positive case",
                                    groupValue: newContact.sourceOfInfection,
                                    onChanged: (value) =>
                                        typeOfContactChosen(value),
                                  ),
                                  Text("Contact with +'ve case"),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: "Markaz",
                                    groupValue: newContact.sourceOfInfection,
                                    onChanged: (value) =>
                                        typeOfContactChosen(value),
                                  ),
                                  Text("Markaz"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CheckboxListTile(
                    title: Text("Is Source Patient Info Available?"),
                    value: newContact.isMorePatientInfoAvailable,
                    onChanged: (bool newValue) {
                      setState(() {
                        newContact.isMorePatientInfoAvailable = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                newContact.isMorePatientInfoAvailable == true
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          onChanged: (value) {
                            this.setState(() {
                              newContact.sourcePatientFirstName = value;
                            });
                          },
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //  style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Source Patient First Name",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            this.setState(() {
                              newContact.sourcePatientFirstName = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                newContact.isMorePatientInfoAvailable == true
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            this.setState(() {
                              newContact.sourcePatientLastName = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //  style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Source Patient Last Name",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            this.setState(() {
                              newContact.sourcePatientLastName = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                newContact.isMorePatientInfoAvailable == true
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            this.setState(() {
                              newContact.sourcePatientAddress = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //  style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Source Patient Address",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            this.setState(() {
                              newContact.sourcePatientAddress = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                newContact.isMorePatientInfoAvailable == true
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            this.setState(() {
                              newContact.sourcePatientNumber = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //  style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Source Patient Number",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            this.setState(() {
                              newContact.sourcePatientNumber = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                Text(
                  "Move the Patient to",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.grey),
                ),
                Container(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width - 50) / 3,
                          child: FlatButton(
                            onPressed: () async {
                              submitTrackingAndMoveToState(0);
                            },
                            color: Theme.of(context).accentColor,
                            child: Provider.of<Patients>(context, listen: true)
                                        .isAddingPatient ==
                                    false
                                ? Text("HOME",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith())
                                : CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                          ),
                        ),

                        Container(
                          width: (MediaQuery.of(context).size.width - 50) / 3,
                          child: FlatButton(
                            onPressed: () async {
                              submitTrackingAndMoveToState(4);
                            },
                            color: Theme.of(context).accentColor,
                            child: Provider.of<Patients>(context, listen: true)
                                        .isUpdating ==
                                    false
                                ? Text(
                                    "ISOLATION WARD",
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.center,
                                  )
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

                        Container(
                          width: (MediaQuery.of(context).size.width - 50) / 3,
                          child: FlatButton(
                            onPressed: () async {
                              submitTrackingAndMoveToState(5);
                            },
                            color: Theme.of(context).accentColor,
                            child: Provider.of<Patients>(context, listen: true)
                                        .isAddingPatient ==
                                    false
                                ? Text("ICU",
                                    style: Theme.of(context).textTheme.caption)
                                : CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                          ),
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
    );
  }
}
