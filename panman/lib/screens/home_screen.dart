import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/address.dart';
import 'package:panman/models/c19data.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/patient.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_inventory_widget.dart';
import '../widgets/home_page_patients_widget.dart';

import '../providers/hospital.dart';
import '../providers/patients.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstName;
  String lastName;
  int age;
  Sex patientSex;
  String hospitalID;
  FullAddress patientAddress = FullAddress(address: "Chandra Layout",city: "Bangalore",state: "Karnataka", zipcode: "560060");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Hospitals>(context, listen: false)
        .getHospitalDetailsFromServer("bGxFisQYmYl8ypnsBDtN");
  }

  void enterFirstName(String newName) {
    setState(() {
      firstName = newName;
    });
  }

  void enterLastName(String newName) {
    setState(() {
      lastName = newName;
    });
  }

  void enterAge(int newage) {
   setState(() {
     age = newage;
   });
  }

  void enterSex(Sex newSex) {
    setState(() {
      patientSex = newSex;
    });
  }

  void AddPatient() {

    print("$firstName, $lastName, ${patientSex.toString()}, ${age.toString()}");
    Provider.of<Patients>(context, listen: false).addPatient(Patient(
      Firstname: firstName,
      LastName: lastName,
      age: age,
      fullAddress: patientAddress,
      id: null,
      currentLocation: 1,
      hospitalID:
          Provider.of<Hospitals>(context, listen: false).fetchedHospital.id,
      sex: patientSex,
      state: null,
      ventilatorUsed: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.add),
          onPressed: () {
            //  _showDialog();
            showDialog(
                context: context,
                child: new MyDialog(
                  ageChanged: enterAge,
                  firstNameChanged: enterFirstName,
                  lastNameChanged: enterLastName,
                  sexChanged: enterSex,
                  addPatient: AddPatient,
                ));
          },
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  Provider.of<Hospitals>(context, listen: true)
                      .fetchedHospital
                      .hospitalName,
                  style: Theme.of(context).textTheme.headline6),
              Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.userMd,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Dr.Joshi",
                      style: Theme.of(context).textTheme.headline6),
                ],
              )
            ],
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.caption,
            labelColor: Colors.white,
            //  isScrollable: true,
            tabs: <Widget>[
              Tab(text: "PATIENTS"),
              Tab(text: "MEDICAL SUPPLIES"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePagePatientsWidget(),
            HomePageInvetoryWidget(),
          ],
        ),
      ),
    );
  }
}

/////////////////////////
///

class MyDialog extends StatefulWidget {
  Function firstNameChanged;
  Function lastNameChanged;
  Function ageChanged;
  Function sexChanged;
  Function addPatient;

  MyDialog(
      {this.firstNameChanged,
      this.lastNameChanged,
      this.ageChanged,
      this.sexChanged,
      this.addPatient});

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  String _selectedId;
  var _formKey = new GlobalKey<FormState>();
  var radioButtonChosen;

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            )),
        height: 50,
        child: Center(
          child: new Text(
            "Add New Patient",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 300,
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "FirstName",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        onSaved: (String value) {
                          widget.firstNameChanged(value);
                        },
                      ),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "LastName",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        onSaved: (String value) {
                          widget.lastNameChanged(value);
                        },
                      ),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Age",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyText1,
                        onSaved: (value) {
                          widget.ageChanged(int.parse(value));
                        },
                      ),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sex",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 230,
                        child: Row(
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: radioButtonChosen,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonChosen = value;
                                  widget.sexChanged(Sex.Male);
                                });
                              },
                            ),
                            Text("Male"),
                            SizedBox(
                              width: 20,
                            ),
                            Radio(
                              value: 1,
                              groupValue: radioButtonChosen,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonChosen = value;
                                  widget.sexChanged(Sex.Female);
                                });
                              },
                            ),
                            Text("Female"),
                          ],
                        )),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new RaisedButton(
          color: Theme.of(context).accentColor,
          child: new Text(
            "Close",
            style: Theme.of(context).textTheme.caption,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new RaisedButton(
          color: Theme.of(context).accentColor,
          child: new Text(
            "Add Patient",
            style: Theme.of(context).textTheme.caption,
          ),
          onPressed: () {
            _formKey.currentState.save();
            widget.addPatient();
          },
        ),
      ],
    );
  }
}
