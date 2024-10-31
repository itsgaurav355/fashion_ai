class Products {
  List<Product>? products;

  Products({products});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? document;
  Metadata? metadata;

  Product({id, document, metadata});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    document = json['document'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['document'] = document;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? name;
  String? category;
  String? price;
  String? imagePath;
  String? description;

  Metadata({name, category, price, imagePath, description});

  Metadata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    price = json['price'].toString();
    imagePath = json['image_path'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['image_path'] = imagePath;
    data['description'] = description;
    return data;
  }
}
