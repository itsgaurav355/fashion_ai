import 'package:easy_stepper/easy_stepper.dart';
import 'package:fashion_ai/controllers/user_controller.dart';
import 'package:fashion_ai/features/get_info/widgets/fashion_info.dart';
import 'package:fashion_ai/features/get_info/widgets/product_info.dart';
import 'package:fashion_ai/features/get_info/widgets/style_info.dart';
import 'package:fashion_ai/features/get_info/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetInfoScreen extends StatefulWidget {
  const GetInfoScreen({super.key});

  @override
  State<GetInfoScreen> createState() => _GetInfoScreenState();
}

class _GetInfoScreenState extends State<GetInfoScreen> {
  List<Widget> steps = [
    const UserInfo(),
    const StyleInfoScreen(),
    const ProductInfo(),
    const FashionInfo(),
    const FashionInfo(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Let's understand your style",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Consumer<UserController>(
              builder: (context, value, child) {
                return EasyStepper(
                  activeStep: value.activeStep,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  stepRadius: 28,
                  finishedStepBorderColor: Colors.black,
                  finishedStepTextColor: Colors.black,
                  finishedStepBackgroundColor: Colors.black,
                  activeStepIconColor: Colors.black,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: value.activeStep >= 0 ? 1 : 0.3,
                          child: Image.asset('assets/images/6.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Your details',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: value.activeStep >= 1 ? 1 : 0.3,
                          child: Image.asset('assets/images/7.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Style details',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: value.activeStep >= 2 ? 1 : 0.3,
                          child: Image.asset('assets/images/3.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Product details',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: value.activeStep >= 3 ? 1 : 0.3,
                          child: Image.asset('assets/images/4.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Fashion details',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: value.activeStep >= 4 ? 1 : 0.3,
                          child: Image.asset('assets/images/5.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'F & R',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  onStepReached: (index) =>
                      setState(() => value.setActiveStep(index)),
                );
              },
            ),
          ),
          Expanded(
              flex: 6,
              child: Consumer<UserController>(builder: (context, value, child) {
                if (value.activeStep == 5) {
                  return const SizedBox();
                }
                return steps[value.activeStep];
              })),
        ],
      ),
    );
  }
}
