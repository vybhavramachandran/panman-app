import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/dashboard.dart';

// import 'package:splashscreen/splashscreen.dart';

// import './providers/medicalSupplies.dart';

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
        // ChangeNotifierProvider.value(
        //   value: Equipment(),
        // ),
      ],
      child: MaterialApp(
        title: 'PanMan-Dashboard',
        theme: ThemeData(
            accentColor: Color.fromRGBO(35, 71, 162, 1),
            primaryColor: Colors.white,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
              ),
              headline5: TextStyle(color: Colors.white),
              caption: TextStyle(fontSize: 15, color: Colors.white),
              bodyText1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        home: SafeArea(
          child: DashBoardScreen(),
        ),
        routes: {
          DashBoardScreen.routeName: (ctx) => DashBoardScreen(),
        },
      ),
    );
  }
}
