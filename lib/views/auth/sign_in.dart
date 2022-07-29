import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/button.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:boilerplate/views/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/navigation.dart';
import '../../utilities/widgets/loader/loader.dart';
import '../../utilities/widgets/textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTxtCtrl = TextEditingController();
  TextEditingController passWordTxtCtrl = TextEditingController();
  @override
  void dispose() {
    emailTxtCtrl.dispose();
    passWordTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PThemes.padding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PTextField(
                  controller: emailTxtCtrl,
                  hintText: 'ex: jahangircpi@gmail.com',
                  label: "Email Address",
                ),
                gapY(10),
                GetBuilder<CAuth>(
                  builder: ((authController) {
                    return PTextField(
                      controller: passWordTxtCtrl,
                      obsecureText: authController.passwordVisible,
                      hintText: 'ex: *****',
                      label: "Password",
                      suffixIcon: InkWell(
                        onTap: () {
                          if (authController.passwordVisible == true) {
                            authController.getPassVisiblity(false);
                          } else {
                            authController.getPassVisiblity(true);
                          }
                        },
                        child: Icon(authController.passwordVisible
                            ? Icons.remove_red_eye
                            : Icons.lock),
                      ),
                    );
                  }),
                ),
                gapY(30),
                signInButton(),
                gapY(40),
                signInDontHaveSection()
              ],
            ),
          ),
          loader(),
        ],
      ),
    );
  }

  GetBuilder<CAuth> signInButton() {
    return GetBuilder<CAuth>(
      builder: ((authController) {
        return PButton(
            text: "Login",
            onTap: () {
              if (emailTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The email's field is empty",
                    snackBarType: SnackBarType.warning);
              } else if (passWordTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The Password's field is empty",
                    snackBarType: SnackBarType.warning);
              } else {
                authController.signIn(
                    email: emailTxtCtrl.text, password: passWordTxtCtrl.text);
              }
            });
      }),
    );
  }

  Row signInDontHaveSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        InkWell(
          onTap: () {
            pushReplacement(
              screen: const SignUpScreen(),
            );
          },
          child: Text(
            ' Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: UdDesign.pt(16),
            ),
          ),
        )
      ],
    );
  }

  GetBuilder<CAuth> loader() {
    return GetBuilder<CAuth>(
      builder: ((signInController) {
        if (signInController.signInDataState == DataState.loading) {
          return const Center(
            child: LoaderBouch(
              color: Colors.black,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
