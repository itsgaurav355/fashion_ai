import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/common_dropdown.dart';
import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userController =
          Provider.of<UserController>(context, listen: false);
      _nameController.text = userController.name;
      _emailController.text = userController.email;
      _ageController.text =
          userController.age == 0 ? '' : userController.age.toString();
      _genderController.text = userController.gender;
      _locationController.text = userController.location;
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _locationController.dispose();
    super.dispose();
  }

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
                "Name*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextField(
                controller: _nameController,
                hintText: "eg. Joe Doe",
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Email*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextField(
                controller: _emailController,
                isEmail: true,
                hintText: 'eg. example@gmail.com',
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Age*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextField(
                inputFormatter: FilteringTextInputFormatter.digitsOnly,
                controller: _ageController,
                hintText: 'Age',
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Gender*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MyDropDownButton(
                  selectedItem: _selectedGender,
                  hint: "Select your gender",
                  items: const ["Male", "Female", "Others"],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedGender = val;
                      });
                    }
                  }),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Location*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextField(
                controller: _locationController,
                hintText: 'eg. New York',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<UserController>(builder: (context, value, child) {
            return CommonButton(
              title: "Next",
              textColor: Colors.white,
              buttonColor: Colors.black,
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _ageController.text.isEmpty ||
                    _selectedGender == null ||
                    _locationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All fields are required"),
                    ),
                  );
                  return;
                } else {
                  value.updateDetails(
                    name: _nameController.text,
                    email: _emailController.text,
                    age: int.parse(_ageController.text),
                    gender: _selectedGender ?? "Male",
                    location: _locationController.text,
                  );
                  value.incrementStep();
                }
              },
              borderRadius: 15,
            );
          })),
    );
  }
}
