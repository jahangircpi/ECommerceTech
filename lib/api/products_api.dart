import 'package:boilerplate/api/urls.dart';
import 'package:dio/dio.dart';

import '../models/products_lists_model.dart';
import '../utilities/services/dio.dart';

class ProductApi {
  static Future<List<MProducts>> productsApi() async {
    Response res = await getHttp(path: PUrls.products);
    return mProductsFromJson(res.data);
  }
}
