import 'package:boilerplate/models/single_caterogry_model.dart';
import 'package:boilerplate/utilities/functions/print.dart';
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

  getCategoryLists() async {
    printer('it is here');
    categoryDataState = DataState.loading;
    notifyListeners();

    try {
      Response res = await getHttp(
        path: PUrls.categoies,
      );

      for (var i = 0; i < res.data.length; i++) {
        categoryLists.add(res.data[i]);
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

      singleCategoryProductDataState = DataState.loaded;
    } catch (e) {
      singleCategoryProductDataState = DataState.error;
    }
    notifyListeners();
  }
}
