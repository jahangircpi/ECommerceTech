import 'package:boilerplate/api/latest_products.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import '../../utilities/constants/enums.dart';

class CLatestProducts extends ChangeNotifier {
  notif() {
    notifyListeners();
  }

  DataState latestProductDataState = DataState.initial;

  List<MProducts> latestProductsLists = <MProducts>[];
  getDataController({required DataState dataState}) {
    latestProductDataState = dataState;
    notif();
  }

  getLatestProductLists() async {
    latestProductDataState = DataState.loading;
    notifyListeners();
    try {
      latestProductsLists = await LatestProductApi.latestProductApi();
      final String encodedData = mProductsToJson(latestProductsLists);
      SharedPreferencesService.instance.setString(
        PKeys.latestProducts,
        encodedData,
      );

      latestProductDataState = DataState.loaded;
    } catch (e) {
      printer(e);
      latestProductDataState = DataState.error;
    }
    notifyListeners();
  }
}
