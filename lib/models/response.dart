class Response {
  String? answer;
  List<RecommendedProducts>? recommendedProducts;
  List<ReusableProducts>? reusableProducts;

  Response({answer, recommendedProducts, reusableProducts});

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

  RecommendedProducts({description, imagePath, name, price});

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
  String? category;
  String? imagePath;

  ReusableProducts({category, imagePath});

  ReusableProducts.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['image_path'] = imagePath;
    return data;
  }
}
