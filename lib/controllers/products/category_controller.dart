import 'dart:convert';
import 'package:boilerplate/models/single_caterogry_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../api/caterogry_api.dart';
import '../../api/urls.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/services/dio.dart';

class CCategory extends ChangeNotifier {
  notif() {
    notifyListeners();
  }

  DataState categoryDataState = DataState.initial;
  DataState singleCategoryProductDataState = DataState.initial;

  List<MSingleCategory> singleCategoryProductsLists = <MSingleCategory>[];
  List categoryLists = [];

  String? selectedCategoryName;
  updateSingleCatProductName({required String value}) {
    selectedCategoryName = value;
    notifyListeners();
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
    notifyListeners();

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
    notifyListeners();
  }

  getSingleCategoryProductLists({required String categoryName}) async {
    singleCategoryProductDataState = DataState.loading;
    notifyListeners();
    try {
      singleCategoryProductsLists =
          await CategoryApi.singleCategoryApi(categoryName: categoryName);
      final String encodedData =
          mSingleCategoryToJson(singleCategoryProductsLists);
      SharedPreferencesService.instance.setString(
        categoryName,
        encodedData,
      );

      singleCategoryProductDataState = DataState.loaded;
    } catch (e) {
      singleCategoryProductDataState = DataState.error;
    }
    notifyListeners();
  }
}
