import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/instance_manager.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/navigation.dart';
import '../views/auth/sign_in.dart';
import '../views/home/home_screen.dart';
import 'auth/auth_controller.dart';

class CheckPointController {
  start() {
    final CAuth authController = Get.put(CAuth());
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      authController.user = auth.currentUser;
      if (authController.user != null) {
        pushAndRemoveUntil(
          screen: HomeScreen(),
        );
      } else {
        pushAndRemoveUntil(
          screen: const SignInScreen(),
        );
      }
    } catch (e) {
      printer(e);
    }
  }
}
