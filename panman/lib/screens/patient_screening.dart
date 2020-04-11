import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:panman/screens/patient_recommendation_screen.dart';
import 'package:provider/provider.dart';

class PatientScreeningScreen extends StatelessWidget {
  _proceed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PatientRecommendationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Patient newPatient = Provider.of<Patients>(context).newPatient;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'SCREENING',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  newPatient.pic == null
                      ? SvgPicture.asset('assets/images/personPin.svg')
                      : Image.file(
                          newPatient.pic,
                          width: 48.0,
                          height: 64.0,
                        ),
                  SizedBox(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${newPatient.Firstname}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.transgender,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'MALE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 32.0),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '${newPatient.age} YEARS',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset('assets/images/depart.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            'C-19 Department',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua?'),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 48,
                          color: Color(0xFF1FB89B),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.0),
                      Expanded(
                        child: Container(
                          height: 48,
                          color: Color(0xFF2347A2),
                          child: Center(
                            child: Text(
                              'NO',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Card(
              color: Colors.white,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua?'),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 48,
                          color: Color(0xFF2347A2),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.0),
                      Expanded(
                        child: Container(
                          height: 48,
                          color: Color(0xFF2347A2),
                          child: Center(
                            child: Text(
                              'NO',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _proceed(context),
              child: Container(
                height: 64.0,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).accentColor,
                child: Center(
                  child: Text(
                    'PROCEED',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
