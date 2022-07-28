import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:flutter/material.dart';

Future push({required Widget screen}) {
  return Navigator.push(
    PKeys.navigatorKey!.currentContext!,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushReplacement({required Widget screen}) {
  Navigator.pushReplacement(
    PKeys.context!,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushAndRemoveUntil({required Widget screen}) {
  Navigator.pushAndRemoveUntil(
      PKeys.context!,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}

void pop({BuildContext? context}) {
  Navigator.pop(PKeys.context!);
}

void popWith({required bool value}) {
  Navigator.pop(PKeys.context!, value);
}
