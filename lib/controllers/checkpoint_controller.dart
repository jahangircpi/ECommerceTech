import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../utilities/functions/print.dart';
import '../utilities/services/navigation.dart';
import '../views/auth/sign_in.dart';
import '../views/home/home_screen.dart';
import 'auth/auth_controller.dart';

class CheckPointController {
  start() {
    SignInController signInController = PKeys.context!.read<SignInController>();
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      signInController.user = auth.currentUser;
      if (signInController.user != null) {
        pushAndRemoveUntil(
          screen: const HomeScreen(),
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