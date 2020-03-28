import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/patient.dart';

class BigAppBarWidget extends StatelessWidget {
  Patient currentPatient;
  String appBarTitle;

  BigAppBarWidget({this.currentPatient, this.appBarTitle});

  BuildContext get context => null;

  patientHeader(Patient patient) {
    String fullname = patient.Firstname + " " + patient.LastName;

    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 0, left: 20),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  fullname,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        patient.sex == Sex.Male
                            ? FaIcon(
                                FontAwesomeIcons.mars,
                                size: 15,
                                color: Colors.white,
                              )
                            : FaIcon(
                                FontAwesomeIcons.female,
                                size: 15,
                                color: Colors.white,
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        patient.sex == Sex.Male
                            ? Text("MALE",
                                style: TextStyle(color: Colors.white))
                            : Text("FEMALE",
                                style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("32 YEARS", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.procedures,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
            
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(160),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          this.appBarTitle,
          style: Theme.of(context).textTheme.caption,
        ),
        centerTitle: true,
        flexibleSpace: patientHeader(currentPatient),
      ),
    );
  }
}
