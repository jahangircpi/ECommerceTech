import 'package:boilerplate/api/latest_products.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:get/get.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/callback.dart';

class CProducts extends GetxController {
  Rx<DataState> productDataState = DataState.initial.obs;

  RxList<MProducts> productsLists = <MProducts>[].obs;
  getDataController({required DataState dataState}) {
    productDataState = dataState.obs;
  }

  getLatestProductLists() async {
    productDataState = DataState.loading.obs;

    try {
      productsLists.value = await LatestProductApi.latestProductApi();
      printer(productsLists.length);
      final String encodedData = mProductsToJson(productsLists);
      SharedPreferencesService.instance.setString(
        PKeys.latestProducts,
        encodedData,
      );

      productDataState = DataState.loaded.obs;
    } catch (e) {
      printer(e);
      productDataState = DataState.error.obs;
    }
  }

  @override
  void onInit() {
    super.onInit();
    callBack(() {
      SharedPreferencesService.instance
          .getString(PKeys.productsLists)
          .then((value) {
        printer(value);
        if (value.isNotEmpty) {
          productsLists.value = MProducts.decode(value);
          getDataController(dataState: DataState.loaded);
        } else {
          getLatestProductLists();
        }
      });
    });
  }
}
