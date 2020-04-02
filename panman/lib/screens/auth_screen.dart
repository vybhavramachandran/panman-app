import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/auth_card_widget.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                //     Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                //   ],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   stops: [0, 1],
                // ),
                ),
          ),
          SingleChildScrollView(
            child: Container(
              // decoration: BoxDecoration(color: Colors.red),
              height: deviceSize.height,
              width: deviceSize.width,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 175,
                  ),

                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("PanMan",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: Colors.black)),
                          Text("Hospital",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      // Text("Enter your username",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .body1
                      //         .copyWith(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 125,
                  ),
                  AuthCard(),
                  //  Flexible(
                  //flex: deviceSize.width > 600 ? 2 : 1,
                  //  child: AuthCard(),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
