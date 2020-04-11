import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:panman/utils/analytics_client.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/covid19.dart';
import './providers/healthcareworkers.dart';
import './providers/hospital.dart';
import './providers/patients.dart';
import './screens/auth_screen.dart';
import './screens/home_page_dashboard.dart';
import './screens/home_screen.dart';
import './screens/patient_detail_assign_equipment_screen.dart';
import './screens/patient_detail_cov19_screen.dart';
import './screens/patient_detail_move_screen.dart';
import './screens/patient_detail_screen.dart';
import './screens/patient_vitals_add_screen.dart';
import './screens/patient_vitals_screen.dart';
import './screens/splash_screen.dart';
import './screens/patient_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  Analytics.instance.logAppOpen();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return MaterialApp(
            title: 'HipoMVPdemo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              buttonColor: Colors.black54,
              accentColor: Colors.deepOrange,
              backgroundColor: Colors.blueGrey,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
                body1: TextStyle(
                    fontFamily: 'OpenSansCondensed',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),
                body2: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
                display1: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                display2: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            home: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "😢",
                      style: TextStyle(fontSize: 45),
                    ),
                    Text(
                      "We couldn't reach our servers!",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 25),
                    ),
                    Text(
                      "Check your internet connectivity",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                )),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: Patients(),
              ),
              // ChangeNotifierProvider.value(
              //   value: Equipment(),
              // ),

              ChangeNotifierProvider.value(
                value: Hospitals(),
              ),

              ChangeNotifierProvider.value(
                value: Auth(),
              ),
              ChangeNotifierProvider.value(
                value: Covid19(),
              ),
              ChangeNotifierProvider.value(
                value: HealthCareWorkers(),
              ),
            ],
            child: Consumer<Auth>(
                builder: (ctx, auth, _) => MaterialApp(
                      title: 'PanMan',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                          accentColor: Color.fromRGBO(35, 71, 162, 1),
                          primaryColor: Colors.white,
                          textTheme: TextTheme(
                            headline6: TextStyle(
                              color: Colors.white,
                            ),
                            headline5: TextStyle(color: Colors.white),
                            caption:
                                TextStyle(fontSize: 15, color: Colors.white),
                            bodyText1: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      home: FutureBuilder<FirebaseUser>(
                          future: auth.tryAutoLogin(),
                          builder: (ctx,
                              AsyncSnapshot<FirebaseUser> authResultSnapshot) {
                            if (authResultSnapshot.connectionState ==
                                    ConnectionState.done ||
                                authResultSnapshot.hasData) {
                              return auth.isAuth
                                  ? SafeArea(child: PatientDashboardScreen())
                                  : AuthScreen();
                            } else {
                              return SplashScreen();
                            }
                          }),
                      routes: {
                        PatientDashboardScreen.routeName :(ctx) => PatientDashboardScreen(),
                        HomeScreen.routeName: (ctx) => HomeScreen(),
                        PatientDetailScreen.routeName: (ctx) =>
                            PatientDetailScreen(),
                        PatientDetailCov19Screen.routeName: (ctx) =>
                            PatientDetailCov19Screen(),
                        PatientDetailMoveScreen.routeName: (ctx) =>
                            PatientDetailMoveScreen(),
                        PatientDetailAssignEquipment.routeName: (ctx) =>
                            PatientDetailAssignEquipment(),
                        DashboardScreen.routeName: (ctx) => DashboardScreen(),
                        AuthScreen.routeName: (ctx) => AuthScreen(),
                        PatientVitalsAddScreen.routeName: (ctx) =>
                            PatientVitalsAddScreen(),
                        PatientVitalsScreen.routeName: (ctx) =>
                            PatientVitalsScreen(),
                      },
                    )),
          );
        }
      },
      child: Container(),
    );
  }
}
