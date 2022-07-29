import 'dart:convert';

List<MSingleCategory> mSingleCategoryFromJson(List str) =>
    List<MSingleCategory>.from(str.map((x) => MSingleCategory.fromJson(x)));

String mSingleCategoryToJson(List<MSingleCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MSingleCategory {
  MSingleCategory({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  factory MSingleCategory.fromJson(Map<String, dynamic> json) =>
      MSingleCategory(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
  static Map<String, dynamic> toMap(MSingleCategory products) => {
        'id': products.id,
        'title': products.title,
        'price': products.price!.toDouble(),
        'description': products.description,
        "category": products.category,
        'image': products.image,
        "content": products.rating?.toJson(),
      };
  // static String encode(List<MSingleCategory> articleslists) => json.encode(
  //       articleslists
  //           .map<Map<String, dynamic>>(
  //               (articleslists) => MSingleCategory.toMap(articleslists))
  //           .toList(),
  //     );

  static List<MSingleCategory> decode(String articleslists) =>
      (json.decode(articleslists) as List<dynamic>)
          .map<MSingleCategory>((item) => MSingleCategory.fromJson(item))
          .toList();
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  double? rate;
  int? count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
