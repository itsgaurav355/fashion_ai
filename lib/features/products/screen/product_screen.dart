import 'dart:developer';

import 'package:fashion_ai/features/add_products/services/product_services.dart';
import 'package:fashion_ai/features/products/screen/shop_product_details.dart';
import 'package:fashion_ai/features/products/widgets/product_card.dart';
import 'package:fashion_ai/models/products.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductServices productServices = ProductServices();
  List<Product> products = [];
  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductScreen oldWidget) {
    fetchAllProducts();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Product Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed('/add-product');
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopProductDetails(
                      product: products[index],
                    ),
                  ),
                );
              },
              child: ProductCard(metaData: products[index].metadata!));
        },
      ),
    );
  }

  void fetchAllProducts() async {
    var res = await productServices.fetchProducts();
    if (res.products == null) return;
    setState(() {
      products = res.products!;
    });
    log(products.length.toString());
  }
}
