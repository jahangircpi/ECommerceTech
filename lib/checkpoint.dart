import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/services/dio.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';
import 'controllers/checkpoint_controller.dart';

class CheckPoint extends StatefulWidget {
  const CheckPoint({Key? key}) : super(key: key);

  @override
  State<CheckPoint> createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  @override
  void initState() {
    DioSingleton.instance.create();
    SharedPreferencesService.instance.create();
    Future.delayed(const Duration(seconds: 1), () {
      CheckPointController().start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(PAssets.splashLogo),
      ),
    );
  }
}
