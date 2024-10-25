import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FashionInfo extends StatefulWidget {
  const FashionInfo({super.key});

  @override
  State<FashionInfo> createState() => _FashionInfoState();
}

class _FashionInfoState extends State<FashionInfo> {
  final TextEditingController _occasionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _occasionController.dispose();
    _descriptionController.dispose();
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
                "Which occasion are you dressing up for?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _occasionController,
                hintText: "eg. Wedding, Party, etc.",
              ),
              const SizedBox(height: 10),
              const Text(
                "Describe the outfit you have in mind",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _descriptionController,
                hintText: "eg. I want a red dress with a slit",
              ),
              Consumer<UserProvider>(builder: (context, value, child) {
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * .9,
                  alignment: Alignment.center,
                  child: CommonButton(
                    title: value.activeStep == 3 ? "Confirm" : "Next",
                    textColor: Colors.white,
                    buttonColor: Colors.black,
                    onPressed: () {
                      if (value.activeStep == 3) {
                        value.storeData();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      } else {
                        value.incrementStep();
                      }
                    },
                    borderRadius: 15,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
