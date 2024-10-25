import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _scrollController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                allowImplicitScrolling: true,
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                onPageChanged: (context) {
                  setState(() {});
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/main1.jpg',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const Text(
                        'Welcome to Fashion AI',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Fashion AI is a virtual stylist that helps you choose the best outfit for any occasion.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Let\'s get started!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/main2.jpg',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const Text(
                        'Upload an Image',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Upload an image of the outfit you want to wear and get suggestions on how to improve it.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Let\'s get started!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/main3.jpg',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const Text(
                        'How to get Started',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Upload an image of the outfit you want to wear and get suggestions on how to improve it.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Let\'s get started!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CommonButton(
              title: "Next",
              textColor: Colors.white,
              buttonColor: Colors.black,
              borderRadius: 15,
              onPressed: () {
                if (_scrollController.page == 2) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/get-info',
                    (route) => false,
                  );
                  return;
                }
                _scrollController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
