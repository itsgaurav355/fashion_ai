import 'dart:developer';

import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  int _age = 0;
  int _activeStep = 0;
  String _gender = '';
  String _location = '';
  String _preferredStyle = '';
  Color _color = Colors.white;
  String _pattern = '';
  String _size = '';
  String _brand = '';
  String _budget = '';
  List<String> _category = [];
  List<String> _product = [];
  List<String> _productSize = [];

  String get name => _name;
  String get email => _email;
  String get password => _password;
  int get age => _age;
  String get gender => _gender;
  String get location => _location;
  int get activeStep => _activeStep;
  String get preferredStyle => _preferredStyle;
  Color get color => _color;
  String get pattern => _pattern;
  String get size => _size;
  String get brand => _brand;
  String get budget => _budget;
  List<String> get category => _category;
  List<String> get product => _product;
  List<String> get productSize => _productSize;

  void setActiveStep(int activeStep) {
    _activeStep = activeStep;
    notifyListeners();
  }

  void reset() {
    _name = '';
    _email = '';
    _password = '';
    _age = 10;
    _activeStep = 0;
  }

  void incrementStep() {
    _activeStep++;
    notifyListeners();
  }

  void decrementStep() {
    _activeStep--;
    notifyListeners();
  }

  void updateDetails(
      {required String name,
      required String email,
      required int age,
      required String gender,
      required String location}) {
    _name = name;
    _email = email;
    _age = age;
    _gender = gender;
    _location = location;
  }

  void updateStyleInfo(
      {String? preferredStyle,
      required Color color,
      required String pattern,
      required String size,
      required String brand,
      String? budget}) {
    _preferredStyle = preferredStyle ?? '';
    _color = color;
    _pattern = pattern;
    _size = size;
    _brand = brand;
    _budget = budget ?? '';
  }

  void setProductInfo(
      {required List<String> category,
      required List<String> product,
      required List<String> size}) {
    log(category.toString());
    log(product.toString());
    log(size.toString());
    _category = category;
    _product = product;
    _productSize = size;
    notifyListeners();
  }
}
