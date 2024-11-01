import 'package:fashion_ai/constants/constants.dart';
import 'package:fashion_ai/models/products.dart';
import 'package:flutter/material.dart';

class ShopProductDetails extends StatelessWidget {
  final Product product;
  const ShopProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          product.metadata!.name!,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: "myproduct/${product.metadata!.name!}",
            child: Image.network(
              "${ApiUrl.baseUrl}${product.metadata!.imagePath!}",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.metadata!.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.metadata!.description!,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price: \$${product.metadata!.price!}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.star, color: Colors.yellow, size: 20),
              const SizedBox(width: 5),
              const Text(
                "4.5",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
