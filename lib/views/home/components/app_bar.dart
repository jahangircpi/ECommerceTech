import 'package:boilerplate/utilities/services/navigation.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_design/ud_design.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/keys.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/widgets/dialog.dart';
import 'edit_profile.dart';

class AppBarHome extends StatelessWidget {
  final CAuth authController = Get.put(CAuth());
  AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.07,
      decoration: const BoxDecoration(color: PColors.appBarColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: UdDesign.pt(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<CAuth>(
              builder: ((autController) {
                return StreamBuilder(
                  stream: PKeys.userCollection
                      .where(
                        'userId',
                        isEqualTo: authController.user!.uid,
                      )
                      .snapshots(),
                  builder:
                      ((context, AsyncSnapshot<QuerySnapshot> personalPost) {
                    if (personalPost.hasData) {
                      var users = personalPost.data!.docs[0];
                      return personalPost.data!.docs.isEmpty
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                    widget: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Container(
                                              height: size.height * 0.1,
                                              width: size.width * 0.2,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white54),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        users['profileImage'] ??
                                                            ""),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: UdDesign.pt(4),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox.shrink(),
                                                  Text(
                                                    users['name'] ?? "",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      push(
                                                        screen: EditProfileUser(
                                                          users: users,
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: size.height * 0.025,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            gapY(5),
                                            Text(users['phoneNumber'] ?? ""),
                                            gapY(5),
                                            Text(users['email'] ?? ""),
                                            gapY(10),
                                          ],
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 15.0, bottom: 15.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                                bottomRight:
                                                    Radius.circular(16.0),
                                              ),
                                            ),
                                            child: const Text(
                                              "Log Out",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 25.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onTap: () {
                                            autController.signOut();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: networkImagescall(
                                  src: personalPost.data!.docs[0]
                                          ['profileImage'] ??
                                      "",
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                              ),
                            );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                );
              }),
            ),
            const Text(
              "Home",
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
