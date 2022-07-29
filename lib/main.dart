import 'package:boilerplate/checkpoint.dart';
import 'package:boilerplate/utilities/constants/colors.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      navigatorKey: PKeys.navigatorKey,
      home: const CheckPoint(),
      theme: ThemeData(
        scaffoldBackgroundColor: PColors.backgroundColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(displayColor: Colors.white, bodyColor: Colors.white),
      ),
    ),
  );
}
