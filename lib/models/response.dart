class Response {
  String? answer;
  List<RecommendedProducts>? recommendedProducts;
  List<ReusableProducts>? reusableProducts;

  Response({this.answer, this.recommendedProducts, this.reusableProducts});

  Response.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    if (json['recommended_products'] != null) {
      recommendedProducts = <RecommendedProducts>[];
      json['recommended_products'].forEach((v) {
        recommendedProducts!.add(RecommendedProducts.fromJson(v));
      });
    }
    if (json['reusable_products'] != null) {
      reusableProducts = <ReusableProducts>[];
      json['reusable_products'].forEach((v) {
        reusableProducts!.add(ReusableProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    if (recommendedProducts != null) {
      data['recommended_products'] =
          recommendedProducts!.map((v) => v.toJson()).toList();
    }
    if (reusableProducts != null) {
      data['reusable_products'] =
          reusableProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendedProducts {
  String? description;
  String? imagePath;
  String? name;
  double? price;

  RecommendedProducts(
      {this.description, this.imagePath, this.name, this.price});

  RecommendedProducts.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imagePath = json['image_path'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['image_path'] = imagePath;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ReusableProducts {
  String? imagePath;
  String? category;

  ReusableProducts({this.imagePath, this.category});

  ReusableProducts.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_path'] = imagePath;
    data['category'] = category;
    return data;
  }
}
