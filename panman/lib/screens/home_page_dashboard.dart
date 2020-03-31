import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/screens/home_screen.dart';
import 'package:panman/widgets/Utilization_card.dart';
import 'package:provider/provider.dart';

import '../providers/hospital.dart';

import '../widgets/Utilization_card.dart';
import '../widgets/Patient_flow_card.dart';
import '../widgets/covid_charts.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
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
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // backgroundColor: Theme.of(context).accentColor,
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //         Provider.of<Hospitals>(context, listen: true)
          //             .fetchedHospital
          //             .hospitalName,
          //         style: Theme.of(context).textTheme.headline6),
          //     Row(
          //       children: <Widget>[
          //         FaIcon(
          //           FontAwesomeIcons.userMd,
          //           color: Colors.white,
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text("Dr.Joshi", style: Theme.of(context).textTheme.headline6),
          //       ],
          //     )
          //   ],
          // ),
        ),
        body: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 4,
                  child: PatientFlowCard(
                            title: "Live Patient Flow",
                            backgroundColor: Colors.blue[200],
                          )),
              Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Container(
                    // color: Colors.red,
                    child: Row(children: <Widget>[
                      Flexible(
                          flex: 3,
                          child: UtilizationCard(
                            title: "Utilization",
                            backgroundColor: Colors.blue[200],
                          )),
                    ]),
                  )),
              Flexible(
                  flex: 4,
                  child: CovidCharts(
                            title: "Covid19",
                            backgroundColor: Colors.blue[200],
                          )),
            ],
          ),
        ),
      ),
    );
  }
}
