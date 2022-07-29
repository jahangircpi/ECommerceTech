import 'package:boilerplate/api/urls.dart';
import 'package:dio/dio.dart';
import '../models/products_lists_model.dart';
import '../utilities/services/dio.dart';

class LatestProductApi {
  static Future<List<MProducts>> latestProductApi() async {
    Response res = await getHttp(path: PUrls.latestProduct);
    return mProductsFromJson(res.data);
  }
}
