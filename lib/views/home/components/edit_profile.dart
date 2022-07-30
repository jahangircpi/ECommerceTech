import 'package:boilerplate/controllers/auth/edit_profile_controller.dart';
import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/back_button.dart';
import 'package:boilerplate/utilities/widgets/button.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/enums.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/services/navigation.dart';
import '../../../utilities/widgets/loader/loader.dart';
import '../../../utilities/widgets/textfield.dart';

class EditProfileUser extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? users;
  const EditProfileUser({Key? key, required this.users}) : super(key: key);

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  final CEditProfile editProfileContrl = Get.put(CEditProfile());
  TextEditingController fullNameTxtCtrl = TextEditingController();
  TextEditingController phoneNumTxtCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameTxtCtrl.text = widget.users!['name'] ?? "";
    phoneNumTxtCtrl.text = widget.users!['phoneNumber'] ?? "";
  }

  @override
  void dispose() {
    fullNameTxtCtrl.dispose();
    phoneNumTxtCtrl.dispose();

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
                    backbutton(context: context, title: 'Edit Profile'),
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
                    gapY(30),
                    uploadButton(),
                    gapY(40),
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

  GetBuilder<CEditProfile> imageSection(Size size) {
    return GetBuilder<CEditProfile>(
      builder: ((editProfileController) {
        return Stack(
          children: [
            Center(
              child: InkWell(
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
                                  editProfileController.getProfileImage(
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
                                  editProfileController.getProfileImage(
                                      cameraOrGallery: true);
                                  pop();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: editProfileController.profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          editProfileController.profileImage!,
                          height: size.height * 0.2,
                          width: size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      )
                    : widget.users!['profileImage'] == null
                        ? Image.asset(
                            PAssets.personLogo,
                            height: size.height * 0.2,
                            width: size.width * 0.4,
                            fit: BoxFit.cover,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: networkImagescall(
                              src: widget.users!['profileImage'] ?? "",
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
              ),
            ),
            editProfileController.imageTakingState == DataState.loading
                ? const Center(
                    child: LoaderBouch(),
                  )
                : const SizedBox.shrink(),
          ],
        );
      }),
    );
  }

  GetBuilder<CEditProfile> uploadButton() {
    return GetBuilder<CEditProfile>(
      builder: ((editProfileController) {
        return PButton(
            text: "Update",
            onTap: () {
              if (fullNameTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The Name's field is empty",
                    snackBarType: SnackBarType.warning);
              } else if (phoneNumTxtCtrl.text.isEmpty) {
                pSnacbar(
                    text: "Oops",
                    title: "The Phone Number's field is empty",
                    snackBarType: SnackBarType.warning);
              } else {
                editProfileController.updateProfile(
                  fullName: fullNameTxtCtrl.text,
                  phoneNumber: phoneNumTxtCtrl.text,
                  userId: '232',
                  previousImage: widget.users!['profileImage'],
                );
              }
            });
      }),
    );
  }

  GetBuilder<CEditProfile> loader() {
    return GetBuilder<CEditProfile>(
      builder: ((editProfileController) {
        if (editProfileController.editProfileStatepDataState ==
            DataState.loading) {
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
