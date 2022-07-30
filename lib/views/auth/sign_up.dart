import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/button.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:boilerplate/views/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/email_verified.dart';
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
  final ValueNotifier<bool> _isValidEmail = ValueNotifier<bool>(false);

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    gapY(50),
                    imageSection(size),
                    PTextField(
                      controller: fullNameTxtCtrl,
                      hintText: 'input your name',
                      label: "Full Name",
                    ),
                    gapY(10),
                    PTextField(
                      controller: phoneNumTxtCtrl,
                      hintText: 'input your phone number',
                      label: "Phone Number",
                    ),
                    gapY(10),
                    PTextField(
                      controller: emailTxtCtrl,
                      label: "Email",
                      onChanged: (v) {
                        _isValidEmail.value = isValidEmail(v);
                      },
                      hintText: "input your email",
                      suffixIcon: ValueListenableBuilder<bool>(
                        builder: (_, value, child) {
                          if (value) {
                            return const Icon(
                              Icons.check,
                              color: Colors.green,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        valueListenable: _isValidEmail,
                      ),
                    ),
                    gapY(10),
                    GetBuilder<CAuth>(
                      builder: ((authController) {
                        return PTextField(
                          obsecureText: authController.passwordVisible,
                          controller: passwordTxtCtrl,
                          label: 'Password',
                          hintText: 'input your password',
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
                    signUPButton(),
                    gapY(40),
                    signUpdontHaveSection()
                  ],
                ),
              ),
            ),
            loader(),
          ],
        ),
      ),
    );
  }

  GetBuilder<CAuth> imageSection(Size size) {
    return GetBuilder<CAuth>(
      builder: ((authController) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PButton(
                          text: "Camera",
                          height: size.height * 0.08,
                          width: size.width * 0.4,
                          backgroundColor: PColors.buttonColor,
                          onTap: () {
                            authController.getProfileImage(
                                cameraOrGallery: false);
                            pop();
                          },
                        ),
                        PButton(
                          text: "Gallery",
                          height: size.height * 0.08,
                          width: size.width * 0.4,
                          backgroundColor: PColors.buttonColor,
                          onTap: () {
                            authController.getProfileImage(
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
                    image: authController.profileImage == null
                        ? const DecorationImage(
                            image: AssetImage(
                              PAssets.personLogo,
                            ),
                            fit: BoxFit.contain,
                          )
                        : DecorationImage(
                            image: FileImage(
                              authController.profileImage!,
                            ),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              authController.imageTakingState == DataState.loading
                  ? const Center(
                      child: LoaderBouch(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }

  GetBuilder<CAuth> signUPButton() {
    return GetBuilder<CAuth>(
      builder: ((authController) {
        return PButton(
            text: "Sign Up",
            onTap: () {
              if (fullNameTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The Name's field is empty",
                    snackBarType: SnackBarType.warning);
              } else if (authController.profileImage == null) {
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
              } else if (_isValidEmail.value == false) {
                pSnacbar(
                    text: "Oops",
                    title: "Input a valid email",
                    snackBarType: SnackBarType.warning);
              } else if (passwordTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The Password's field is empty",
                    snackBarType: SnackBarType.warning);
              } else {
                authController.signUp(
                    fullName: fullNameTxtCtrl.text,
                    phoneNumber: phoneNumTxtCtrl.text,
                    email: emailTxtCtrl.text,
                    password: passwordTxtCtrl.text);
              }
            });
      }),
    );
  }

  Widget signUpdontHaveSection() {
    return Row(
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
    );
  }

  GetBuilder<CAuth> loader() {
    return GetBuilder<CAuth>(
      builder: ((authController) {
        if (authController.signInDataState == DataState.loading) {
          return const Center(
            child: LoaderBouch(),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
