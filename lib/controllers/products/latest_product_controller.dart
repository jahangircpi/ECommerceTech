import 'package:boilerplate/models/single_caterogry_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import '../../api/caterogry_api.dart';
import '../../utilities/constants/enums.dart';

class CLatestProducts extends ChangeNotifier {
  notif() {
    notifyListeners();
  }

  DataState latestProductDataState = DataState.initial;

  List<MProducts> latestProductsLists = <MProducts>[];

  getLatestProductLists({required String categoryName}) async {
    latestProductDataState = DataState.loading;
    notifyListeners();
    try {
      latestProductsLists =
          await CategoryApi.singleCategoryApi(categoryName: categoryName);
      final String encodedData = mProductsToJson(latestProductsLists);
      SharedPreferencesService.instance.setString(
        PKeys.latestProducts,
        encodedData,
      );

      latestProductDataState = DataState.loaded;
    } catch (e) {
      latestProductDataState = DataState.error;
    }
    notifyListeners();
  }
}
