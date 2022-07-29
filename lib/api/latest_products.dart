import 'package:boilerplate/api/urls.dart';
import 'package:dio/dio.dart';
import '../models/single_caterogry_model.dart';
import '../utilities/services/dio.dart';

class LatestProductApi {
  static Future<List<MProducts>> latestProductApi(
      {required String categoryName}) async {
    Response res = await getHttp(path: PUrls.latestProduct);
    return mProductsFromJson(res.data);
  }
}
