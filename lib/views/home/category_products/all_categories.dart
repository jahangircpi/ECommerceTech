import 'package:boilerplate/views/home/category_products/single_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_design/ud_design.dart';

import '../../../controllers/products/category_controller.dart';
import '../../../controllers/products/search_controller.dart';
import '../../../utilities/constants/enums.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/services/navigation.dart';

class CategorySectionHomescreen extends StatelessWidget {
  final Size size;
  final CCategory categoryController = Get.put(CCategory());
  CategorySectionHomescreen({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: UdDesign.fontSize(16),
              ),
            ),
          ],
        ),
        gapY(5),
        GetBuilder<CCategory>(
          builder: ((categorycontroller) {
            if (categorycontroller.categoryDataState == DataState.loaded) {
              return Column(
                children: [
                  gapY(8),
                  SizedBox(
                    height: UdDesign.pt(50),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categorycontroller.categoryLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        var lists = categorycontroller.categoryLists[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01),
                          child: GetBuilder<CSearch>(
                            builder: ((searchController) {
                              return InkWell(
                                onTap: () async {
                                  categorycontroller.updateSingleCatProductName(
                                      value: lists);

                                  push(
                                    screen: SingleCategoryProductsScreen(
                                      titleofPage: lists ?? "",
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: UdDesign.pt(0.9)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: UdDesign.pt(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          lists ?? "",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (categorycontroller.categoryDataState ==
                DataState.loading) {
              return const SizedBox.shrink();
            } else if (categorycontroller.categoryDataState ==
                DataState.error) {
              return const Center(
                child: Text('There are some problems'),
              );
            } else {
              return const Center(
                child: Text('The list is empty'),
              );
            }
          }),
        ),
        gapY(16),
      ],
    );
  }
}
