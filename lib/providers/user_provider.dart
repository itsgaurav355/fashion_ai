import 'dart:developer';
import 'dart:io';

import 'package:fashion_ai/common/widgets/utils.dart';
import 'package:fashion_ai/features/home/services/home_services.dart';
import 'package:fashion_ai/models/stylist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  int _age = 0;
  int _activeStep = 0;
  String _gender = '';
  String _location = '';
  String _preferredStyle = '';
  String _intagramUrl = '';
  double _height = 0.0;
  double _weight = 0.0;
  Color _color = Colors.white;
  String _pattern = '';
  String data = '';
  HomeServices homeServices = HomeServices();

  String _brand = '';
  String _budget = '';
  List<String> _category = [];
  List<String> _product = [];
  List<String> _productSize = [];
  List<String> _images = [];

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
  String get brand => _brand;
  String get budget => _budget;
  List<String> get category => _category;
  List<String> get product => _product;
  List<String> get productSize => _productSize;
  String get instagramUrl => _intagramUrl;
  double get height => _height;
  double get weight => _weight;
  List<String> get images => _images;

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

  Future<void> uploadImages(List<String> images) async {
    //store in local storage
    _images.addAll(images);
    for (var image in images) {
      await homeServices.uploadImage(File(image), "itsgaurav355");
    }
    notifyListeners();
  }

  //fetch all the images from local storage
  void fetchAllImages() async {
    _images.clear();
    List<File> images = await Utils.fetchAllImages();
    for (var image in images) {
      _images.add(image.path);
      log('Image Path: ${image.path}');
    }
    notifyListeners();
  }

  void updateDetails(
      {required String name,
      required String email,
      required int age,
      required String gender,
      required String location,
      required String instagramUrl,
      required double height,
      required double weight}) {
    _name = name;
    _email = email;
    _age = age;
    _gender = gender;
    _location = location;
    _intagramUrl = instagramUrl;
    _height = height;
    _weight = weight;
    notifyListeners();
  }

  void updateStyleInfo(
      {String? preferredStyle,
      required Color color,
      required String pattern,
      required String brand,
      String? budget}) {
    _preferredStyle = preferredStyle ?? '';
    _color = color;
    _pattern = pattern;
    _brand = brand;
    _budget = budget ?? '';
    notifyListeners();
  }

  void storeData() async {
    //store data in shared preferences
    String data =
        "My name is $_name, I am $_age years old, I live in $_location,Give me some suggestion style $_gender and preffered style is $_preferredStyle,in $_color,of pattern $_pattern,brand $_brand,in budget $_budget, ${_category.join(',')}, ${_product.join(',')}, ${_productSize.join(',')}, ";
    log(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('data', data);
    prefs.setString('name', _name);
    prefs.setString('email', _email);
    prefs.setInt('age', _age);
    prefs.setString('location', _location);
    notifyListeners();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString('data') ?? "";
    _name = prefs.getString('name') ?? "";
    _email = prefs.getString('email') ?? "";
    _age = prefs.getInt('age') ?? 0;
    _location = prefs.getString('location') ?? "";
    fetchAllImages();
    log(data.toString());
    notifyListeners();
  }

  void setProductInfo(
      {required List<String> category,
      required List<String> product,
      required List<String> size}) {
    _category = category;
    _product = product;
    _productSize = size;
    notifyListeners();
  }

  List<Stylist> stylists = [
    Stylist(
      name: 'John Doe',
      description:
          'I am a professional hair stylist with 5 years of experience, specializing in modern cuts and personalized hair care.',
      location: 'Lagos, Nigeria',
      rating: 4.5,
      specialist: "Hair Stylist",
      imageUrl:
          'https://media.vanityfair.com/photos/55ef2bb0fad0d98d444cdb61/master/w_1600%2Cc_limit/fashion-illustrators-meagan-morrison-chiara-ferragni.jpg',
      instagramUrl: 'https://instagram.com/johndoe',
    ),
    Stylist(
      name: 'Jane Doe',
      description:
          'I am a professional makeup artist with 5 years of experience, dedicated to enhancing natural beauty and creating stunning looks.',
      location: 'Lagos, Nigeria',
      specialist: "Makeup Artist",
      rating: 4.0,
      imageUrl:
          'https://i.pinimg.com/736x/71/c0/90/71c090c1ee401a79f7b84c086fa04063.jpg',
      instagramUrl: 'https://instagram.com/janedoe',
    ),
    Stylist(
      name: 'John Doe',
      description:
          'I specialize in fashion design with a focus on innovative trends and timeless elegance, bringing visions to life.',
      location: 'Lagos, Nigeria',
      rating: 4.5,
      specialist: "Designer",
      imageUrl:
          'https://ielfs.com/wp-content/uploads/2015/10/article_what_is_a_Fashion_stylist_role_during_A_fashion_shoot.jpg',
      instagramUrl:
          'https://www.onlinedegree.com/wp-content/uploads/2016/11/fashion-stylist-700x449.jpg',
    ),
    Stylist(
      name: 'Jane Doe',
      description:
          'As a dressing stylist, I curate outfits for various occasions, ensuring every client feels confident and stylish.',
      location: 'Lagos, Nigeria',
      specialist: "Dressing Stylist",
      rating: 4.0,
      imageUrl:
          'https://www.onlinedegree.com/wp-content/uploads/2016/11/fashion-stylist-700x449.jpg',
      instagramUrl:
          'https://ielfs.com/wp-content/uploads/2015/10/article_what_is_a_Fashion_stylist_role_during_A_fashion_shoot.jpg',
    ),
    Stylist(
      name: 'Michael Smith',
      description:
          'With over 7 years in the industry, I specialize in contemporary menswear and personal shopping, ensuring every client looks sharp and feels confident.',
      location: 'Lagos, Nigeria',
      rating: 4.8,
      specialist: "Menswear Stylist",
      imageUrl:
          'https://b-six.com/cdn/shop/articles/fashion-stylist-must-haves-for-fashion-week-fw22-122831.jpg?v=1678602241',
      instagramUrl: 'https://instagram.com/michaelsmith',
    ),
    Stylist(
      name: 'Emily Johnson',
      description:
          'As a creative fashion consultant focused on sustainable styles, I aim to transform your wardrobe while respecting the planet.',
      location: 'Lagos, Nigeria',
      rating: 4.7,
      specialist: "Sustainable Fashion Stylist",
      imageUrl:
          'https://i.pinimg.com/736x/71/c0/90/71c090c1ee401a79f7b84c086fa04063.jpg',
      instagramUrl: 'https://instagram.com/emilyjohnson',
    ),
    Stylist(
      name: 'Sophia Brown',
      description:
          'I am a vibrant and energetic stylist specializing in bold colors and eclectic looks. Let’s create a unique style that showcases your personality!',
      location: 'Lagos, Nigeria',
      rating: 4.6,
      specialist: "Fashion Innovator",
      imageUrl:
          'https://ielfs.com/wp-content/uploads/2015/10/article_what_is_a_Fashion_stylist_role_during_A_fashion_shoot.jpg',
      instagramUrl: 'https://instagram.com/sophiabrown',
    ),
    Stylist(
      name: 'David Wilson',
      description:
          'With a background in high fashion, I offer luxury styling services that cater to red carpet events and upscale occasions.',
      location: 'Lagos, Nigeria',
      rating: 4.9,
      specialist: "Luxury Fashion Stylist",
      imageUrl:
          'https://b-six.com/cdn/shop/articles/fashion-stylist-must-haves-for-fashion-week-fw22-122831.jpg?v=1678602241',
      instagramUrl: 'https://instagram.com/davidwilson',
    ),
  ];
}
