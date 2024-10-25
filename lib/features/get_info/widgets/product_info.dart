import 'dart:developer';

import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/common_dropdown.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final List<String> _sizeList = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];
  List<String> categoryList = [
    "Shoes",
    "Clothes",
    "Accessories",
    "Bags",
    "Jewelry",
  ];

  List<String> maleProductList = [
    'Shirts',
    'T-shirts',
    'Jeans',
    'Denim Jacket',
    'Shorts',
    'Sweater',
    'Hoodie',
    'Jacket',
    'Blazer',
    'Suit',
  ];

  List<String> femaleProductList = [
    'Shirts',
    'T-shirts',
    'Jeans',
    'Shorts',
    'One Piece',
    'Sweater',
    'Hoodie',
    'Jacket',
    'Blazer',
    'Suit',
    'Skirt',
    'Dress',
    'Kurti',
    'Saree',
  ];
  final List<String> _selectedCategory = [];
  final List<String> _selectedProduct = [];
  final List<String> _selectedProductSize = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category*",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                MyDropDownButton(
                    hint: "Select Categories",
                    items: categoryList,
                    onChanged: (val) {
                      if (val == null) {
                        return;
                      }
                      setState(() {
                        if (!_selectedCategory.contains(val)) {
                          _selectedCategory.add(val);
                        } else {
                          _selectedCategory.remove(val);
                        }
                      });
                    }),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _selectedCategory
                      .map(
                        (category) => FilterChip(
                          label: Text(category),
                          selected: _selectedCategory.contains(category),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategory.add(category);
                              } else {
                                _selectedCategory.remove(category);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Products*",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Consumer<UserProvider>(
                  builder: (context, value, child) {
                    log(value.age.toString());
                    return MyDropDownButton(
                      hint: "Select Categories",
                      items: value.gender == "Male"
                          ? maleProductList
                          : femaleProductList,
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          if (!_selectedProduct.contains(val)) {
                            _selectedProduct.add(val);
                          } else {
                            _selectedProduct.remove(val);
                          }
                        });
                      },
                    );
                  },
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _selectedProduct
                      .map(
                        (product) => FilterChip(
                          label: Text(product),
                          selected: _selectedProduct.contains(product),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedProduct.add(product);
                              } else {
                                _selectedProduct.remove(product);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Size*",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _sizeList
                      .map(
                        (size) => FilterChip(
                          label: Text(size),
                          selected: _selectedProductSize.contains(size),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedProductSize.add(size);
                              } else {
                                _selectedProductSize.remove(size);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<UserProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: CommonButton(
                borderRadius: 15,
                title: "Next",
                textColor: Colors.white,
                onPressed: () {
                  if (_selectedCategory.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a category'),
                      ),
                    );
                    return;
                  }
                  if (_selectedProduct.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a product'),
                      ),
                    );
                  }
                  if (_selectedProductSize.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a size'),
                      ),
                    );
                    return;
                  }
                  // Navigate to next screen
                  value.setProductInfo(
                    category: _selectedCategory,
                    product: _selectedProduct,
                    size: _selectedProductSize,
                  );
                  value.incrementStep();
                },
                buttonColor: Colors.black,
              ),
            );
          },
        ));
  }
}
