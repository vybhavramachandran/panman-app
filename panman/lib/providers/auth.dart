import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panman/utils/analytics_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Auth with ChangeNotifier {
  bool tryingToAuthenticate = false;
  FirebaseUser loggedinUser;

  String _userEmail;
  String _userPassword;
  String _token;
  String _userID;

  Future login(String email, String password) async {
    tryingToAuthenticate = true;
    notifyListeners();
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Analytics.instance.logLogin();

      FirebaseUser user = result.user;
      loggedinUser = result.user;

      Analytics.instance.setUserId(userId: loggedinUser.uid);

      if (user != null) {
        _token = user.getIdToken().toString();
        _userEmail = user.email;
        _userID = user.uid;
        tryingToAuthenticate = false;
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userID,
            'userEmail': _userEmail,
            // 'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
      } else {
        tryingToAuthenticate = false;

        _token = null;
        notifyListeners();
      }
    } catch (error) {
      tryingToAuthenticate = false;
      notifyListeners();
      throw (error);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _token = null;
    _userID = null;
    _userEmail = null;
    loggedinUser = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<FirebaseUser> tryAutoLogin() async {
    if (loggedinUser == null) {
      final FirebaseUser user = await _auth.currentUser();
      //  print("Auto Login called ${user.toString()}");
      if (user != null) {
        loggedinUser = user;
        _token = user.getIdToken().toString();
        _userID = user.uid;
        notifyListeners();
        //  print("TryAutoLogin returning user ${user.toString()}");
        return user;
      } else {
        return null;
      }
    }
    return loggedinUser;
    // print("tryAutoLogin called");
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userID;
  }

  String get userEmail {
    return _userEmail;
  }
}
