import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/address.dart';

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

import 'package:panman/models/c19data.dart';
import 'package:panman/models/healthcareworker.dart';
import 'package:panman/models/hospital.dart';
import 'package:panman/models/patient.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_inventory_widget.dart';
import '../widgets/home_page_patients_widget.dart';
import './home_page_dashboard.dart';

import '../providers/hospital.dart';
import '../providers/patients.dart';
import '../providers/covid19.dart';
import '../providers/auth.dart';
import '../providers/healthcareworkers.dart';

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
  String newPatientID;
  bool isAdding = false;
  bool triggerRefreshOfPatientList = false;

  FullAddress patientAddress = FullAddress(
      address: "Chandra Layout",
      city: "Bangalore",
      state: "Karnataka",
      zipcode: "560060");

  Future fetchFuture;
  bool _isLoading = false;

  @override
  void initState() {
    Provider.of<Hospitals>(context, listen: false)
        .getReferenceMedicalSupplyList();
    Provider.of<Hospitals>(context, listen: false)
        .getReferenceHospitalLocationList();
    fetchFuture = fetchDoctorAndHospitalDetails();
    super.initState();
  }

  Future fetchDoctorAndHospitalDetails() async {
    print("fetchingDoctorAndHospitalDetials");
    await Provider.of<HealthCareWorkers>(context, listen: false)
        .getHCWDetailsFromServer(
            Provider.of<Auth>(context, listen: false).loggedinUser.uid);

    await Provider.of<Hospitals>(context, listen: false)
        .getHospitalDetailsFromServer(
            Provider.of<HealthCareWorkers>(context, listen: false)
                .hcwloggedin
                .hospitalID);

    return true;
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

  void patientListRefreshed(){
    setState(){
      triggerRefreshOfPatientList = false;
    }
  }

  void AddPatient() async {
  
    print("$firstName, $lastName, ${patientSex.toString()}, ${age.toString()}");
    try {
      await Provider.of<Patients>(context, listen: false).addPatient(Patient(
        Firstname: firstName,
        LastName: lastName,
        age: age,
        fullAddress: patientAddress,
        id: newPatientID,
        currentLocation: 1,
        hospitalID:
            Provider.of<Hospitals>(context, listen: false).fetchedHospital.id,
        sex: patientSex,
        state: referenceCovid19SeverityLevelsList[0],
        ventilatorUsed: false,
      ));
      Navigator.pop(context);
      setState(() {
        triggerRefreshOfPatientList = true;
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              snapshot.hasError) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                drawer: SafeArea(
                  child: Drawer(
                    // Add a ListView to the drawer. This ensures the user can scroll
                    // through the options in the drawer if there isn't enough vertical
                    // space to fit everything.
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Text(
                            'Menu',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        ListTile(
                          title: Text('Dashboards'),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                            return Navigator.pushNamed(
                              context,
                              DashboardScreen.routeName,
                            );
                          },
                        ),
                        ListTile(
                          title: Text('Treatment'),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                            return Navigator.pushNamed(
                              context,
                              HomeScreen.routeName,
                            );
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Logout',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.red),
                          ),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Provider.of<HealthCareWorkers>(context,
                                    listen: false)
                                .logoutHCW();
                            Provider.of<Auth>(context, listen: false).logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      newPatientID = randomAlphaNumeric(10);
                    });
                    //  _showDialog();
                    showDialog(
                        context: context,
                        child: new MyDialog(
                          patientID: newPatientID,
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
                      SizedBox(
                        width: 200.0,
                        child: FittedBox(
                          child: Text(
                              Provider.of<Hospitals>(context, listen: true)
                                  .fetchedHospital
                                  .hospitalName,
                              style: Theme.of(context).textTheme.headline6),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.userMd,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              Provider.of<HealthCareWorkers>(context,
                                      listen: true)
                                  .hcwloggedin
                                  .firstName,
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
                    HomePagePatientsWidget(
                        triggerRefreshOfPatientList:
                            triggerRefreshOfPatientList,
                        ),
                    HomePageInvetoryWidget(),
                  ],
                ),
              ),
            );
          }
        });
  }
}

/////////////////////////
///

class MyDialog extends StatefulWidget {
  String patientID;
  Function firstNameChanged;
  Function lastNameChanged;
  Function ageChanged;
  Function sexChanged;
  Function addPatient;

  MyDialog({
    this.patientID,
    this.firstNameChanged,
    this.lastNameChanged,
    this.ageChanged,
    this.sexChanged,
    this.addPatient,
  });

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
                      "PatientID",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.patientID,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                )),
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
        Provider.of<Patients>(context, listen: true).isAddingPatient == false
            ? new RaisedButton(
                color: Theme.of(context).accentColor,
                child: new Text(
                  "Add Patient",
                  style: Theme.of(context).textTheme.caption,
                ),
                onPressed: () {
                  _formKey.currentState.save();
                  widget.addPatient();
                },
              )
            : CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
      ],
    );
  }
}
