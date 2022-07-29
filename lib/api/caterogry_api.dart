import 'package:boilerplate/api/urls.dart';
import 'package:dio/dio.dart';
import '../models/single_caterogry_model.dart';
import '../utilities/services/dio.dart';

class CategoryApi {
  static Future<List<MSingleCategory>> singleCategoryApi(
      {required String categoryName}) async {
    Response res =
        await getHttp(path: PUrls.singleCategory(category: categoryName));
    return mSingleCategoryFromJson(res.data);
  }
}
