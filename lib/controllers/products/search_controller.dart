import 'package:get/get_state_manager/get_state_manager.dart';

import '../../models/products_lists_model.dart';

class CSearch extends GetxController {
  notify() {
    update();
  }

  List<MProducts> searchLists = <MProducts>[];
  searchingProducts(
      {required String? value, required List<MProducts> listName}) {
    searchLists = listName.where((element) {
      return element.title!
          .toString()
          .toLowerCase()
          .contains(value!.toString().toLowerCase());
    }).toList();
    notify();
  }
}
