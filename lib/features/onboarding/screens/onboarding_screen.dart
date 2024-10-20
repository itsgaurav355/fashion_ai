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
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text('Introduction'),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellow,
                      alignment: Alignment.center,
                      child: const Text('Overview'),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: const Text(
                        'How to get Started',
                        textAlign: TextAlign.center,
                      ),
                    ),
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
