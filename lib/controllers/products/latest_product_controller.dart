import 'package:boilerplate/api/latest_products.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/callback.dart';

class CLatestProducts extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callBack(() {
      SharedPreferencesService.instance
          .getString(PKeys.latestProducts)
          .then((value) {
        printer(value);
        if (value.isNotEmpty) {
          latestProductsLists = MProducts.decode(value);
          getDataController(dataState: DataState.loaded);
          notify();
        } else {
          getLatestProductLists();
        }
      });
    });
  }

  notify() {
    update();
  }

  DataState latestProductDataState = DataState.initial;

  List<MProducts> latestProductsLists = <MProducts>[];
  getDataController({required DataState dataState}) {
    latestProductDataState = dataState;
    notify();
  }

  getLatestProductLists() async {
    latestProductDataState = DataState.loading;
    notify();
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
    notify();
  }
}
