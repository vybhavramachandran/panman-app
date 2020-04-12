import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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


      FirebaseUser user = result.user;
      loggedinUser = result.user;


      if (user != null) {
        var temp = await user.getIdToken();
        _token = temp.token;
        print("_token is"+_token);
        _userEmail = user.email;
        _userID = user.uid;
        tryingToAuthenticate = false;
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        print(_token);
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
        var temp = await user.getIdToken();
        _token = temp.token;
        _userID = user.uid;
        _userEmail = user.email;
          final prefs = await SharedPreferences.getInstance();
          
          print("tryautologin called ${_token}");
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userID,
            'userEmail': _userEmail,
            // 'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
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
