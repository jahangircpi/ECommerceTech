import 'dart:convert';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../api/caterogry_api.dart';
import '../../api/urls.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/services/dio.dart';

class CCategory extends GetxController {
  notify() {
    update();
  }

  DataState categoryDataState = DataState.initial;
  DataState singleCategoryProductDataState = DataState.initial;

  List<MProducts> singleCategoryProductsLists = <MProducts>[];

  List categoryLists = [];

  String? selectedCategoryName;
  updateSingleCatProductName({required String value}) {
    selectedCategoryName = value;
    notify();
  }

  getDataController({required DataState dataState}) {
    categoryDataState = dataState;
    notify();
  }

  getSingleCatDataController({required DataState dataState}) {
    singleCategoryProductDataState = dataState;
    notify();
  }

  getCategoryLists() async {
    categoryDataState = DataState.loading;
    notify();

    try {
      Response res = await getHttp(
        path: PUrls.categoies,
      );

      for (var i = 0; i < res.data.length; i++) {
        categoryLists.add(res.data[i]);
        SharedPreferencesService.instance.setString(
          PKeys.categoryLists,
          json.encode(categoryLists),
        );
      }

      categoryDataState = DataState.loaded;
    } catch (e) {
      printer('or here');
      categoryDataState = DataState.error;
    }
    notify();
  }

  getSingleCategoryProductLists({required String categoryName}) async {
    singleCategoryProductDataState = DataState.loading;
    notify();
    try {
      singleCategoryProductsLists =
          await CategoryApi.singleCategoryApi(categoryName: categoryName);
      final String encodedData = mProductsToJson(singleCategoryProductsLists);
      SharedPreferencesService.instance.setString(
        categoryName,
        encodedData,
      );

      singleCategoryProductDataState = DataState.loaded;
    } catch (e) {
      singleCategoryProductDataState = DataState.error;
    }
    notify();
  }

  @override
  void onInit() {
    super.onInit();
    //for Categories Lists//
    SharedPreferencesService.instance
        .getString(PKeys.categoryLists)
        .then((value) {
      if (value.isNotEmpty) {
        var data = json.decode(value);
        categoryLists.addAll(data);
        getDataController(dataState: DataState.loaded);
        notify();
      } else {
        getCategoryLists();
      }
    });
  }
}
