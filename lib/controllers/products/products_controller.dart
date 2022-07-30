import 'package:boilerplate/api/products_api.dart';
import 'package:boilerplate/models/products_lists_model.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/functions/print.dart';
import 'package:boilerplate/utilities/services/shared_pref.dart';
import 'package:get/get.dart';
import '../../utilities/constants/enums.dart';

class CProducts extends GetxController {
  Rx<DataState> productDataState = DataState.initial.obs;
  RxList<MProducts> productsLists = <MProducts>[].obs;
  getDataController({required DataState dataState}) {
    productDataState.value = dataState;
  }

  getLatestProductLists() async {
    productDataState.value = DataState.loading;

    try {
      productsLists.value = await ProductApi.productsApi();
      final String encodedData = mProductsToJson(productsLists);
      SharedPreferencesService.instance.setString(
        PKeys.productsLists,
        encodedData,
      );

      productDataState.value = DataState.loaded;
    } catch (e) {
      printer(e);
      productDataState.value = DataState.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
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
  }
}
