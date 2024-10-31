class RecommendateProduct {
  String? productName;
  String? imageUrl;
  int? price;

  RecommendateProduct({productName, imageUrl, price});

  RecommendateProduct.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    imageUrl = json['image_url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['image_url'] = imageUrl;
    data['price'] = price;
    return data;
  }
}
