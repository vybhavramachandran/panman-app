import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/providers/auth.dart';
import 'package:panman/providers/healthcareworkers.dart';
import 'package:panman/providers/hospital.dart';
import 'package:panman/screens/patient_registration_screen.dart';
import 'package:provider/provider.dart';

class PatientDashboardScreen extends StatefulWidget {
  @override
  _PatientDashboardScreenState createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    await Provider.of<HealthCareWorkers>(context, listen: false)
        .getHCWDetailsFromServer(
            Provider.of<Auth>(context, listen: false).loggedinUser.uid);
    await Provider.of<Hospitals>(context, listen: false)
        .getHospitalDetailsFromServer(
            Provider.of<HealthCareWorkers>(context, listen: false)
                .hcwloggedin
                .hospitalID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Provider.of<Hospitals>(context, listen: true)
              .fetchedHospital
              .hospitalName,
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.solidUserCircle,
                color: Colors.white,
              ),
              SizedBox(width: 12.0),
              Text(
                Provider.of<HealthCareWorkers>(context, listen: true)
                        .hcwloggedin
                        ?.firstName ??
                    "",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PatientRegistrationScreen())),
          child: Card(
            elevation: 4.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 42.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset('assets/images/patient.svg'),
                  SizedBox(height: 32.0),
                  Text(
                    'REGISTER PATIENT',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
