library q1_util;

import 'dart:async';

import 'package:flutter/material.dart';

class Q1Utils {
  static String showTowNumber(int number) {
    return number.toString().length > 1 ? number.toString() : '0$number';
  }

  /// showDetailWhenShowYear: If conversation please pass false.
  static String formatRecentTime(int? senderTime, bool showDetailWhenShowYear) {
    if (senderTime == null) {
      return 'unknown';
    }
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(senderTime);
    final DateTime now = DateTime.now();
    final int today =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final int yesterday =
        DateTime(now.year, now.month, now.day - 1).millisecondsSinceEpoch;
    if (senderTime >= today) {
      return '${showTowNumber(dateTime.hour)}:${showTowNumber(dateTime.minute)}';
    } else if (senderTime >= yesterday) {
      return '${'Yesterday'} ${showTowNumber(dateTime.hour)}:${showTowNumber(dateTime.minute)}';
    } else {
      return "${showTowNumber(dateTime.month)}/${showTowNumber(dateTime.day)} ${dateTime.year}${showDetailWhenShowYear ? " ${showTowNumber(dateTime.hour)}:${showTowNumber(dateTime.minute)}" : ""}";
    }
  }
}

extension Q1BoolExtension on bool {
  bool not() => !this;
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

mixin AutoCloseStreamSubscription on ChangeNotifier {
  List<StreamSubscription> subscriptionList = <StreamSubscription>[];

  void addSubscription(StreamSubscription subscription) {
    subscriptionList.add(subscription);
  }

  void closeWorkList() {
    for (var subscription in subscriptionList) {
      subscription.cancel();
    }
  }

  @override
  void dispose() {
    closeWorkList();
    super.dispose();
  }
}
