import 'package:boilerplate/controllers/products/search_controller.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_design/ud_design.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/services/navigation.dart';
import '../all_product_shown_screen.dart';
import '../details_product.dart';

class ProductWithListSection extends StatelessWidget {
  final CSearch searchController = Get.put(CSearch());
  final List<MProducts> productLists;
  ProductWithListSection({Key? key, required this.productLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Products',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: UdDesign.fontSize(13),
              ),
            ),
            GetBuilder<CSearch>(
              builder: ((searchController) {
                return InkWell(
                  onTap: () {
                    searchController.searchLists = List.from(productLists);

                    push(
                      screen: ProductsShownScreen(
                        titleofPage: 'Latest Products',
                        productLists: productLists,
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: UdDesign.fontSize(13),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        SizedBox(
          height: UdDesign.pt(190),
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productLists.length,
              itemBuilder: (_, index) {
                MProducts items = productLists[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.00001),
                  child: GestureDetector(
                    onTap: () {
                      push(
                        screen: ProductScreen(
                          products: items,
                        ),
                      );
                    },
                    child: SizedBox(
                      width: UdDesign.pt(130),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: UdDesign.pt(12),
                          vertical: UdDesign.pt(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            items.image == null
                                ? Image.asset(items.image ?? "")
                                : networkImagescall(
                                    src: items.image!,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                            gapY(5),
                            Text(
                              items.title!,
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
                                  "Price",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UdDesign.fontSize(11),
                                  ),
                                ),
                                Text(
                                  "৳${items.price!.toString()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UdDesign.fontSize(11),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UdDesign.fontSize(11),
                                  ),
                                ),
                                Text(
                                  "${items.rating?.rate ?? ""}",
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
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
