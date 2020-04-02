import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/auth.dart';

enum AuthMode { Email, Phone }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String errorMessage = "";

  AnimationController _controller;

  Animation<double> _opacityAnimation;
  Animation<Size> _heightAnimation;
  AnimationStatus _animationStatus;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  Widget errorSnackBar(String text, String actionLabel) {
    return SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: actionLabel,
          onPressed: () {},
        ));
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _heightAnimation = Tween<Size>(
      begin: Size(double.infinity, 260),
      end: Size(double.infinity, 320),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _heightAnimation.addStatusListener((status) {
      setState(() {
        _animationStatus = status;
        print(_animationStatus.toString());
      });
    });

    // //  _heightAnimation.addListener(() => setState(() {}));
    // // TODO: implement initState
    // PhoneNumber = FocusNode();
    // OTP = FocusNode();
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } catch (error) {
      print(error.message);
      setState(){
        errorMessage = error.message;
      }

   //   Provider.of<Auth>(context, listen: false).resetLoadingBool();
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      //  height: 300,
      //shape: RoundedRectangleBorder(
      //  borderRadius: BorderRadius.circular(10.0),
      //),
      //elevation: 8.0,
      child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          // height: 260,
          //  height: _heightAnimation.value.height,
          // constraints: BoxConstraints(maxWidth: 200),
          //width: deviceSize.width * 0.75,
          //padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Text(errorMessage,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.red)),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Email",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        //      borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    // decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      print("Value : ${value}");
                      _authData['email'] = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        //      borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Provider.of<Auth>(context).tryingToAuthenticate == true
                      ? CircularProgressIndicator()
                      : ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 400, maxWidth: 200),
                          child: RaisedButton(
                            child: Provider.of<Auth>(context, listen: true)
                                        .tryingToAuthenticate ==
                                    false
                                ? Text('LOGIN')
                                : CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                            onPressed: _submit,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).accentColor,
                          ),
                        ),
                ],
              ),
            ),
          )),
    );
  }
}
