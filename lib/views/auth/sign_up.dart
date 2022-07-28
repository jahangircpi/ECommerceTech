import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/button.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:boilerplate/views/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/navigation.dart';
import '../../utilities/widgets/loader/loader.dart';
import '../../utilities/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameTxtCtrl = TextEditingController();
  TextEditingController phoneNumTxtCtrl = TextEditingController();
  TextEditingController emailTxtCtrl = TextEditingController();
  TextEditingController passwordTxtCtrl = TextEditingController();
  @override
  void dispose() {
    fullNameTxtCtrl.dispose();
    phoneNumTxtCtrl.dispose();
    emailTxtCtrl.dispose();
    passwordTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PThemes.padding,
              ),
              child: Consumer<SignInController>(
                builder: ((context, signInController, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gapY(50),
                        Consumer<SignInController>(
                          builder: ((context, signInController, child) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        height: size.height * 0.1,
                                        decoration: const BoxDecoration(
                                          color: PColors.backgroundColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            PButton(
                                              text: "Camera",
                                              height: size.height * 0.08,
                                              width: size.width * 0.4,
                                              backgroundColor:
                                                  PColors.buttonColor,
                                              onTap: () {
                                                signInController
                                                    .getProfileImage(
                                                        cameraOrGallery: false);
                                                pop();
                                              },
                                            ),
                                            PButton(
                                              text: "Gallery",
                                              height: size.height * 0.08,
                                              width: size.width * 0.4,
                                              backgroundColor:
                                                  PColors.buttonColor,
                                              onTap: () {
                                                signInController
                                                    .getProfileImage(
                                                        cameraOrGallery: true);
                                                pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: size.width * 0.5,
                                      height: size.height * 0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        shape: BoxShape.circle,
                                        image: signInController.profileImage ==
                                                null
                                            ? const DecorationImage(
                                                image: AssetImage(
                                                  PAssets.personLogo,
                                                ),
                                                fit: BoxFit.contain,
                                              )
                                            : DecorationImage(
                                                image: FileImage(
                                                  signInController
                                                      .profileImage!,
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                    ),
                                  ),
                                  signInController.imageTakingState ==
                                          DataState.loading
                                      ? const Center(
                                          child: LoaderBouch(color: Colors.red),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            );
                          }),
                        ),
                        PTextField(
                          controller: fullNameTxtCtrl,
                          hintText: 'ex: Jahangir Alam',
                          label: "Full Name",
                        ),
                        gapY(10),
                        PTextField(
                          controller: phoneNumTxtCtrl,
                          hintText: 'ex: +8801700000000',
                          label: "Phone Number",
                        ),
                        gapY(10),
                        PTextField(
                          controller: emailTxtCtrl,
                          hintText: 'ex: jahangircpi@gmail.com',
                          label: "Email Address",
                        ),
                        gapY(10),
                        PTextField(
                          obsecureText: signInController.passwordVisible,
                          controller: passwordTxtCtrl,
                          label: 'Password',
                          hintText: 'ex: *****',
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
                            text: "Sign Up",
                            onTap: () {
                              if (fullNameTxtCtrl.text.isEmpty) {
                                pSnacbar(
                                    text: "Oops",
                                    title: "The Name's field is empty",
                                    snackBarType: SnackBarType.warning);
                              } else if (signInController.profileImage ==
                                  null) {
                                pSnacbar(
                                  text: "Oops",
                                  title: "Pick a Profile Image.",
                                  snackBarType: SnackBarType.warning,
                                );
                              } else if (phoneNumTxtCtrl.text.isEmpty) {
                                pSnacbar(
                                    text: "Oops",
                                    title: "The Phone Number's field is empty",
                                    snackBarType: SnackBarType.warning);
                              } else if (emailTxtCtrl.text.isEmpty) {
                                pSnacbar(
                                    text: "Oops",
                                    title: "The email's field is empty",
                                    snackBarType: SnackBarType.warning);
                              } else if (passwordTxtCtrl.text.isEmpty) {
                                pSnacbar(
                                    text: "Oops",
                                    title: "The Password's field is empty",
                                    snackBarType: SnackBarType.warning);
                              } else {
                                signInController.signUp(
                                    fullName: fullNameTxtCtrl.text,
                                    phoneNumber: phoneNumTxtCtrl.text,
                                    email: emailTxtCtrl.text,
                                    password: passwordTxtCtrl.text);
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
                                  screen: const SignInScreen(),
                                );
                              },
                              child: Text(
                                ' Log in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: UdDesign.pt(16),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
      ),
    );
  }
}
