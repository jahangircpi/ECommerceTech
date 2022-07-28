import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/button.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:boilerplate/views/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            child: Consumer<SignInController>(
              builder: ((context, signInController, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PTextField(
                      controller: emailTxtCtrl,
                      hintText: 'ex: jahangircpi@gmail.com',
                      label: "Email Address",
                    ),
                    gapY(10),
                    PTextField(
                      controller: passWordTxtCtrl,
                      obsecureText: signInController.passwordVisible,
                      hintText: 'ex: *****',
                      label: "Password",
                      suffixIcon: InkWell(
                        onTap: () {
                          if (signInController.passwordVisible == true) {
                            signInController.getPassVisiblity(false);
                          } else {
                            signInController.getPassVisiblity(true);
                          }
                        },
                        child: Icon(signInController.passwordVisible
                            ? Icons.remove_red_eye
                            : Icons.lock),
                      ),
                    ),
                    gapY(30),
                    PButton(
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
                            signInController.signIn(
                                email: emailTxtCtrl.text,
                                password: passWordTxtCtrl.text);
                          }
                        }),
                    gapY(40),
                    Row(
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
                    )
                  ],
                );
              }),
            ),
          ),
          Consumer<SignInController>(
            builder: ((context, signInController, child) {
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
          ),
        ],
      ),
    );
  }
}
