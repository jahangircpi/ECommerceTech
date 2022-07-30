import 'package:boilerplate/controllers/products/category_controller.dart';
import 'package:boilerplate/controllers/products/latest_product_controller.dart';
import 'package:boilerplate/controllers/products/products_controller.dart';
import 'package:boilerplate/controllers/products/search_controller.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/navigation.dart';
import 'category_products/single_category_screen.dart';
import 'components/app_bar.dart';
import 'components/latest_product_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final CLatestProducts latestProductController = Get.put(CLatestProducts());
  final CProducts allProductController = Get.put(CProducts());
  final CCategory categoryController = Get.put(CCategory());
  final CSearch searchController = Get.put(CSearch());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarHome(),
            gapY(10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PThemes.padding,
              ),
              child: Column(
                children: [
                  _categorySection(size),
                  gapY(10),
                  latestProductSection(),
                  gapY(10),
                  allProductSSection(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _categorySection(size) {
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
                                  printer(lists);
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

  GetBuilder<CLatestProducts> latestProductSection() {
    return GetBuilder<CLatestProducts>(
      builder: ((
        latestProductController,
      ) {
        if (latestProductController.latestProductDataState ==
            DataState.loaded) {
          return ProductWithListSection(
            title: 'Latest Products',
            productLists: latestProductController.latestProductsLists,
          );
        } else if (latestProductController.latestProductDataState ==
            DataState.loading) {
          return const SizedBox.shrink();
        } else if (latestProductController.latestProductDataState ==
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
    );
  }

  allProductSSection() {
    return Obx(() {
      try {
        {
          if (allProductController.productDataState.value == DataState.loaded) {
            return ProductWithListSection(
              title: 'All Products',
              productLists: allProductController.productsLists,
            );
          } else if (allProductController.productDataState.value ==
              DataState.loading) {
            return const LoaderBouch();
          } else if (allProductController.productDataState.value ==
              DataState.error) {
            return const Center(
              child: Text('There are some problems'),
            );
          } else {
            return const Center(
              child: Text('The list is empty'),
            );
          }
        }
      } catch (e) {
        return const Center(
          child: LoaderBouch(),
        );
      }
    });
  }
}
