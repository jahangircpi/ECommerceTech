class PUrls {
  static const baseUrl = 'https://fakestoreapi.com';
  static const products = '$baseUrl/products';
  static const singleProduct = '$baseUrl/products/1';
  static const limitProduct = '$baseUrl/products?limit=5';
  static const categoies = '$baseUrl/products/categories';
  static singleCategory({required String category}) =>
      '$baseUrl/products/category/$category';
}
