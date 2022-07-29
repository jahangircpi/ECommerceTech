import 'package:boilerplate/models/single_caterogry_model.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/assets.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/navigation.dart';

class ProductScreen extends StatelessWidget {
  final MSingleCategory? products;
  const ProductScreen({Key? key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.85,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PThemes.padding),
                      child: Column(
                        children: [
                          gapY(10),
                          backbutton(context),
                          basicDetailsofaProduct(),
                          gapY(10),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PThemes.padding),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: UdDesign.pt(16),
                              ),
                            ),
                            gapY(5),
                            Text(
                              products!.description ?? "",
                              style: TextStyle(
                                fontSize: UdDesign.fontSize(12),
                                height: UdDesign.pt(1.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  basicDetailsofaProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapY(10),
        Center(
          child: products!.image == null
              ? Image.asset(PAssets.personLogo)
              : networkImagescall(
                  src: products!.image ?? "",
                  height: UdDesign.pt(200),
                  width: double.infinity,
                ),
        ),
        gapY(15),
        Text(
          products!.title ?? "",
          style:
              TextStyle(fontSize: UdDesign.pt(18), fontWeight: FontWeight.w600),
        ),
        gapY(15),
        Text(
          'Total Rating ${products!.rating!.count ?? ""}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: UdDesign.pt(16),
          ),
        ),
        gapY(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category : ${products!.category ?? ""}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: UdDesign.pt(16),
              ),
            ),
          ],
        ),
        Text(
          'Rating : ${products!.rating!.rate ?? ""}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: UdDesign.pt(16),
          ),
        ),
        Text(
          'Total Rating : ${products!.rating!.count ?? ""}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: UdDesign.pt(16),
          ),
        ),
      ],
    );
  }

  Widget backbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            pop();
          },
        ),
      ],
    );
  }
}
