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
  notif() {
    update();
  }

  DataState categoryDataState = DataState.initial;
  DataState singleCategoryProductDataState = DataState.initial;

  List<MProducts> singleCategoryProductsLists = <MProducts>[];
  List categoryLists = [];

  String? selectedCategoryName;
  updateSingleCatProductName({required String value}) {
    selectedCategoryName = value;
    notif();
  }

  getDataController({required DataState dataState}) {
    categoryDataState = dataState;
    notif();
  }

  getSingleCatDataController({required DataState dataState}) {
    singleCategoryProductDataState = dataState;
    notif();
  }

  getCategoryLists() async {
    categoryDataState = DataState.loading;
    notif();

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
    notif();
  }

  getSingleCategoryProductLists({required String categoryName}) async {
    singleCategoryProductDataState = DataState.loading;
    notif();
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
    notif();
  }
}
