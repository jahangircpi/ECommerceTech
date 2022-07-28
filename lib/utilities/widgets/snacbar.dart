import 'package:another_flushbar/flushbar.dart';
import 'package:boilerplate/utilities/constants/colors.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../constants/keys.dart';

pSnacbar(
    {String? title,
    required String text,
    SnackBarType snackBarType = SnackBarType.warning}) {
  Flushbar(
    title: title,
    message: text,
    leftBarIndicatorColor: snackBarType == SnackBarType.warning
        ? Colors.red
        : snackBarType == SnackBarType.success
            ? Colors.green
            : PColors.primary,
    icon: Icon(
      Icons.warning_amber_outlined,
      color: snackBarType == SnackBarType.warning
          ? Colors.red
          : snackBarType == SnackBarType.success
              ? Colors.green
              : PColors.primary,
    ),
    duration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(8),
    margin: const EdgeInsets.symmetric(horizontal: PThemes.padding),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(PKeys.context!);
}
