import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/keys.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/widgets/dialog.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

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
            Consumer<CAuth>(
              builder: ((context, autController, child) {
                return StreamBuilder(
                  stream: PKeys.userCollection
                      .where(
                        'userId',
                        isEqualTo: autController.user!.uid,
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
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            gapY(10),
                                            Text(users['name'] ?? ""),
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
                              child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white54),
                                  image: DecorationImage(
                                    image: NetworkImage(personalPost
                                            .data!.docs[0]['profileImage'] ??
                                        ""),
                                  ),
                                ),
                              ),
                            );
                    } else {
                      return const Center(
                        child: Text('No data found'),
                      );
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
