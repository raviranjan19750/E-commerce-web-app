

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:sentry_flutter/sentry_flutter.dart';

class AnalyticsService{

  FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);


  Future setUserProperties({String userID}) async {
    try{
      await _firebaseAnalytics.setUserId(userID);
    }catch(exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }

  }

  Future sendAnalyticsEvent({String eventName, Map<String, dynamic> eventParameters}) async {

    try{
      await _firebaseAnalytics.logEvent(name: eventName, parameters: eventParameters);
    }catch(exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

}