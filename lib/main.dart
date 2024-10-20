import 'package:fashion_ai/controllers/user_controller.dart';
import 'package:fashion_ai/features/get_info/screens/get_info.dart';
import 'package:fashion_ai/features/home/screens/home_screen.dart';
import 'package:fashion_ai/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion AI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnBoardingScreen(),
        routes: {
          // Add the routes here
          '/onboarding': (context) => const OnBoardingScreen(),
          '/get-info': (context) => const GetInfoScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
