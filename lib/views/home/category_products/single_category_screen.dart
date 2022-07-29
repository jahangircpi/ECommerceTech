import 'package:boilerplate/controllers/products/category_controller.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/widgets/loader/loader.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:boilerplate/utilities/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_design/ud_design.dart';
import '../../../utilities/constants/enums.dart';
import '../../../utilities/constants/themes.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/services/navigation.dart';
import '../../../utilities/widgets/back_button.dart';
import '../details_product.dart';

class SingleCategoryProductsScreen extends StatelessWidget {
  final String titleofPage;
  SingleCategoryProductsScreen({Key? key, required this.titleofPage})
      : super(key: key);
  final CCategory categoryController = Get.put(CCategory());
  final TextEditingController searchTxtCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PThemes.padding),
                child: Column(
                  children: [
                    gapY(10),
                    backbutton(context: context, title: titleofPage),
                    gapY(10),
                    GetBuilder<CCategory>(
                      builder: ((categoryController) {
                        return PTextField(
                          hintText: 'ex: LG',
                          controller: searchTxtCtrl,
                          onChanged: (v) {
                            categoryController.searchingProducts(value: v);
                          },
                        );
                      }),
                    ),
                    GetBuilder<CCategory>(
                      builder: ((categoryController) {
                        if (categoryController.singleCategoryProductDataState ==
                            DataState.loaded) {
                          return gridbodylists();
                        } else if (categoryController
                                .singleCategoryProductDataState ==
                            DataState.loading) {
                          return const LoaderBouch();
                        } else if (categoryController
                                .singleCategoryProductDataState ==
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridbodylists() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categoryController.searchLists.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: UdDesign.pt(2),
          crossAxisSpacing: UdDesign.pt(5),
          childAspectRatio: 0.9),
      itemBuilder: (context, index) {
        MProducts items = categoryController.searchLists[index];
        return GestureDetector(
          onTap: () {
            push(
              screen: ProductScreen(
                products: items,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: UdDesign.pt(12),
              vertical: UdDesign.pt(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                items.image == null
                    ? Image.asset(PAssets.personLogo)
                    : networkImagescall(
                        src: items.image ?? "",
                        fit: BoxFit.contain,
                      ),
                gapY(5),
                Text(
                  items.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: UdDesign.fontSize(12),
                      fontWeight: FontWeight.w600),
                ),
                gapY(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "৳ ${items.price!.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: UdDesign.fontSize(11),
                      ),
                    ),
                    Text(
                      'Rating: ${items.rating?.rate ?? ""}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: UdDesign.fontSize(11),
                      ),
                    ),
                  ],
                ),
                gapY(7),
              ],
            ),
          ),
        );
      },
    );
  }
}
