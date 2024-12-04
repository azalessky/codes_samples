import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

enum AnalyticsEvent {
  assignmentsShowList,
  assignmentsMarkDone,
  notesShowList,
  notesAddItem,
  notesDeleteItem,
  notesUpdateItem,
  subjectsShowList,
  subjectsAddItem,
  subjectsDeleteItem,
  subjectsUpdateItem,
  subjectsResetItems,
  teachersShowList,
  teachersAddItem,
  teachersDeleteItem,
  teachersUpdateItem,
  termsShowList,
  termsAddItem,
  termsDeleteItem,
  termsUpdateItem,
  bellsShowList,
  bellsSetStart,
  bellsSetEnd,
  gradesSelectView,
  gradesShowBook,
  gradesShowReport,
  gradesShowHistory,
  scheduleResetScroll,
  scheduleSelectSubject,
  scheduleSelectGrade,
  homeworkShow,
  homeworkUpdate,
  homeworkPickImage,
  homeworkViewImage,
  homeworkDeleteImage,
  homeworkShareText,
  homeworkShareImages,
  homeworkMarkDone,
  userSignIn,
  settingsUpdate,
  cloudSync,
  adLoaded,
  adFailed,
  adClicked,
  adImpression,
}

class AnalyticsHelper {
  final analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(AnalyticsEvent event) async {
    final name = _camelToSnake(event.name);

    try {
      await analytics.logEvent(name: name);
      debugPrint('logEvent: event=$name');
    } catch (e) {
      debugPrint('logEvent: $e}');
    }
  }

  String _camelToSnake(String str) {
    final regex = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return str.split(regex).join('_').toLowerCase();
  }
}
