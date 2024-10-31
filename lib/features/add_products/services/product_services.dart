import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fashion_ai/models/products.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  final String apiUrl = 'http://192.168.1.104:5000';

  Future<void> addProduct(String name, String description, File image,
      String category, double price) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/store-product'),
    );

    request.fields['product_name'] = name;
    request.fields['description'] = description;
    request.fields['category'] = category;
    request.fields['price'] = price.toString();

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        log(jsonDecode(responseBody).toString());
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  Future<Products> fetchProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/fetch-products'));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      log(responseBody.toString());
      return Products.fromJson(responseBody);
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }
}
