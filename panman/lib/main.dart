import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:splashscreen/splashscreen.dart';

import './models/c19data.dart';

import './providers/patients.dart';
// import './providers/medicalSupplies.dart';
import './providers/hospital.dart';
import './providers/covid19.dart';
import './providers/auth.dart';
import './providers/healthcareworkers.dart';

import './screens/home_screen.dart';
import './screens/patient_detail_screen.dart';
import './screens/patient_detail_cov19_screen.dart';
import './screens/patient_detail_move_screen.dart';
import './screens/patient_detail_assign_equipment_screen.dart';
import './screens/home_page_dashboard.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      caption: TextStyle(fontSize: 15, color: Colors.white),
                      bodyText1:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                home: FutureBuilder<FirebaseUser>(
                    future: auth.tryAutoLogin(),
                    builder:
                        (ctx, AsyncSnapshot<FirebaseUser> authResultSnapshot) {
                      if (authResultSnapshot.connectionState ==
                              ConnectionState.done ||
                          authResultSnapshot.hasData) {
                        return auth.isAuth
                            ? SafeArea(child: HomeScreen())
                            : AuthScreen();
                      } else {
                        return SplashScreen();
                      }
                    }),
                routes: {
                  HomeScreen.routeName: (ctx) => HomeScreen(),
                  PatientDetailScreen.routeName: (ctx) => PatientDetailScreen(),
                  PatientDetailCov19Screen.routeName: (ctx) =>
                      PatientDetailCov19Screen(),
                  PatientDetailMoveScreen.routeName: (ctx) =>
                      PatientDetailMoveScreen(),
                  PatientDetailAssignEquipment.routeName: (ctx) =>
                      PatientDetailAssignEquipment(),
                  DashboardScreen.routeName: (ctx) => DashboardScreen(),
                  AuthScreen.routeName: (ctx) => AuthScreen(),
                },
              )),
    );
  }
}
