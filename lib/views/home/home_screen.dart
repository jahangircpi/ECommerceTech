import 'package:boilerplate/controllers/products/latest_product_controller.dart';
import 'package:boilerplate/controllers/products/products_controller.dart';
import 'package:boilerplate/controllers/products/search_controller.dart';
import 'package:boilerplate/utilities/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import 'category_products/all_categories.dart';
import 'components/app_bar.dart';
import 'components/latest_product_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final CLatestProducts latestProductController = Get.put(CLatestProducts());
  final CProducts allProductController = Get.put(CProducts());
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
                  CategorySectionHomescreen(size: size),
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
