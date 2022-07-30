import 'package:get/instance_manager.dart';
import '../utilities/services/navigation.dart';
import '../views/auth/sign_in.dart';
import '../views/home/home_screen.dart';
import 'auth/auth_controller.dart';

class CheckPointController {
  start() {
    final CAuth authController = Get.put(CAuth());

    try {
      authController.user = authController.auth.currentUser;
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
      pushAndRemoveUntil(
        screen: const SignInScreen(),
      );
    }
    authController.notify();
  }
}
