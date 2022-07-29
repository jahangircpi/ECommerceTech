import 'package:boilerplate/controllers/products/category_controller.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:boilerplate/utilities/functions/callback.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/navigation.dart';
import 'category_products/single_category_screen.dart';
import 'components/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    callBack(() {
      PKeys.context!.read<CCategory>().getCategoryLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarHome(),
            gapY(10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PThemes.padding,
              ),
              child: Column(
                children: [
                  _categorySection(size),
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
                fontWeight: FontWeight.w500,
                fontSize: UdDesign.fontSize(16),
              ),
            ),
          ],
        ),
        gapY(5),
        Consumer<CCategory>(
          builder: ((context, categorycontroller, child) {
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
                          child: InkWell(
                            onTap: () {
                              categorycontroller.updateSingleCatProductName(
                                  value: lists);
                              printer(categorycontroller.selectedCategoryName ??
                                  "");
                              push(
                                  screen: SingleCategoryProductsScreen(
                                titleofPage: lists ?? "",
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white,
                                    width: UdDesign.pt(0.9)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: UdDesign.pt(12),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (categorycontroller.categoryDataState ==
                    DataState.loading ||
                categorycontroller.categoryDataState == DataState.initial) {
              return const Center(
                  child: LoaderBouch(
                color: Colors.red,
              ));
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
