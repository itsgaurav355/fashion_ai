import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/common_dropdown.dart';
import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/common/widgets/utils.dart';
import 'package:fashion_ai/features/add_products/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _category;
  List<String> _imagePath = [];
  bool _isLoading = false;
  ProductServices productServices = ProductServices();
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  addProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _category == null ||
        _imagePath.isEmpty) {
      Utils.showSnackBar(context, "All fields are required");
      return;
    } else if (double.parse(_priceController.text.trim()) < 0) {
      Utils.showSnackBar(context, "Please enter a valid price");
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await productServices.addProduct(
            _nameController.text.trim(),
            _descriptionController.text.trim(),
            File(_imagePath[0]),
            _category!,
            double.parse(_priceController.text.trim()));
        if (mounted) {
          Navigator.pop(context);
          Utils.showSnackBar(context, "Product added successfully");
        }
      } catch (e) {
        if (mounted) {
          Utils.showSnackBar(context, "Error adding product: $e");
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Add Product",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: _isLoading
              ? const RepaintBoundary(
                  child: SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _imagePath.isEmpty
                          ? SizedBox(
                              height: 180,
                              width: 180,
                              child: GestureDetector(
                                onTap: () async {
                                  final image = await Utils.pickImages();
                                  if (image.isNotEmpty) {
                                    setState(() {
                                      _imagePath = image;
                                    });
                                  }
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: const Center(
                                        child: Icon(
                                          Icons.photo_library,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: _imagePath.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(File(_imagePath[index])),
                                  );
                                },
                              ),
                            ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Enter Product Name*"),
                          const SizedBox(height: 8),
                          MyTextField(
                            controller: _nameController,
                            hintText: "e.g. Shirt",
                          ),
                          const SizedBox(height: 8),
                          const Text("Enter Product Description*"),
                          const SizedBox(height: 8),
                          MyTextField(
                            controller: _descriptionController,
                            hintText: "e.g. Casual look shirt for men",
                          ),
                          const SizedBox(height: 8),
                          const Text("Select Category*"),
                          const SizedBox(height: 8),
                          MyDropDownButton(
                              hint: "Select Category",
                              items: const [
                                "T-shirt/top",
                                "Trouser",
                                "Pullover",
                                "Dress",
                                "Coat",
                                "Sandal",
                                "Shirt",
                                "Sneaker",
                                "Bag",
                                "Ankle boot"
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _category = value;
                                  });
                                }
                              }),
                          const SizedBox(height: 8),
                          const Text("Enter Product Price in \$ *"),
                          const SizedBox(height: 8),
                          MyTextField(
                            onChanged: (value) {
                              if (value.isNotEmpty && value != "0") {
                                _priceController.text = value;
                              }
                            },
                            controller: _priceController,
                            hintText: "e.g. 1000",
                            inputFormatter:
                                FilteringTextInputFormatter.digitsOnly,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CommonButton(
                            title: "Add Product",
                            textColor: Colors.white,
                            buttonColor: Colors.black,
                            onPressed: addProduct,
                            borderRadius: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
