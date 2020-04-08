import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class Analytics {
  Analytics._();

  static final instance = Analytics._();
  static final _analytics = FirebaseAnalytics();
  static final _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  FirebaseAnalyticsObserver get observer => _observer;

  Future<void> logLogin({String loginMethod}) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logSignUp({String signUpMethod}) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> logEvent({@required String name, Map parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logSearch({@required String text}) async {
    await _analytics.logSearch(searchTerm: text);
  }

  Future<void> setUserProperty({
    @required String name,
    @required String value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  Future<void> setUserId({@required String userId}) async {
    await _analytics.setUserId('$userId');
  }

  Future<void> resetAnalytics() async {
    await _analytics.resetAnalyticsData();
  }
}
