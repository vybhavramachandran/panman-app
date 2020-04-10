import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:provider/provider.dart';

class PatientRecommendationScreen extends StatelessWidget {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'BASED ON THE INFORMATION ENTERED THIS IS THE RECOMMENDED ACTION: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              color: Color(0xFFD7F3FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset('assets/images/isolation.svg'),
                    Spacer(),
                    Text(
                      'Move to isolation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 28.0,
                      width: 28.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF1FB89B),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset('assets/images/home.svg'),
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Home quarantine & proceed with further testing',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
