import 'package:boilerplate/api/urls.dart';
import 'package:dio/dio.dart';
import '../models/products_lists_model.dart';
import '../utilities/services/dio.dart';

class CategoryApi {
  static Future<List<MProducts>> singleCategoryApi(
      {required String categoryName}) async {
    Response res =
        await getHttp(path: PUrls.singleCategory(category: categoryName));
    return mProductsFromJson(res.data);
  }
}
