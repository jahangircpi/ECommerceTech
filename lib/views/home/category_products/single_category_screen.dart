import 'package:boilerplate/controllers/products/category_controller.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:boilerplate/utilities/widgets/loader/loader.dart';
import 'package:boilerplate/utilities/widgets/network_image.dart';
import 'package:boilerplate/utilities/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../../utilities/constants/enums.dart';
import '../../../utilities/constants/themes.dart';
import '../../../utilities/functions/callback.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/services/navigation.dart';
import '../../../utilities/services/shared_pref.dart';
import '../../../utilities/widgets/back_button.dart';
import '../details_product.dart';

class SingleCategoryProductsScreen extends StatefulWidget {
  final String titleofPage;
  const SingleCategoryProductsScreen({Key? key, required this.titleofPage})
      : super(key: key);

  @override
  State<SingleCategoryProductsScreen> createState() =>
      _SingleCategoryProductsScreenState();
}

class _SingleCategoryProductsScreenState
    extends State<SingleCategoryProductsScreen> {
  TextEditingController searchTxtCtrl = TextEditingController();
  List<MProducts>? searchLists = <MProducts>[];
  @override
  void initState() {
    super.initState();
    CCategory categoryController = context.read<CCategory>();
    callBack(() {
      SharedPreferencesService.instance
          .getString(widget.titleofPage)
          .then((value) {
        if (value.isNotEmpty) {
          categoryController.singleCategoryProductsLists =
              MProducts.decode(value);
          categoryController.getSingleCatDataController(
              dataState: DataState.loaded);
          categoryController.notif();
        } else {
          categoryController.getSingleCategoryProductLists(
              categoryName: categoryController.selectedCategoryName!);
        }
        searchLists = categoryController.singleCategoryProductsLists;
        setState(() {});
      });
    });
  }

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
                    backbutton(context: context, title: widget.titleofPage),
                    gapY(10),
                    Consumer<CCategory>(
                      builder: ((context, categoryController, child) {
                        return PTextField(
                          hintText: 'ex: LG',
                          controller: searchTxtCtrl,
                          onChanged: (v) {
                            searchLists = categoryController
                                .singleCategoryProductsLists
                                .where((element) {
                              return element.title!
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                    v.toString().toLowerCase(),
                                  );
                            }).toList();
                            setState(() {});
                          },
                        );
                      }),
                    ),
                    Consumer<CCategory>(
                      builder: ((context, categorycontroller, child) {
                        if (categorycontroller.singleCategoryProductDataState ==
                            DataState.loaded) {
                          return gridbodylists();
                        } else if (categorycontroller
                                .singleCategoryProductDataState ==
                            DataState.loading) {
                          return const LoaderBouch(
                            color: Colors.red,
                          );
                        } else if (categorycontroller
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
      itemCount: searchLists!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: UdDesign.pt(2),
          crossAxisSpacing: UdDesign.pt(5),
          childAspectRatio: 0.9),
      itemBuilder: (context, index) {
        MProducts items = searchLists![index];
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
