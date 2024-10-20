import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FashionInfo extends StatelessWidget {
  const FashionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, value, child) {
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width * .9,
        alignment: Alignment.center,
        child: CommonButton(
          title: value.activeStep == 4 ? "Confirm" : "Next",
          textColor: Colors.white,
          buttonColor: Colors.black,
          onPressed: () {
            if (value.activeStep == 4) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            } else {
              value.incrementStep();
            }
          },
          borderRadius: 15,
        ),
      );
    });
  }
}
