import 'package:fashion_ai/features/home/screens/bottom_natigation.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:fashion_ai/features/get_info/screens/get_info.dart';
import 'package:fashion_ai/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    getLoggedInStatus();
    super.initState();
  }

  getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion AI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            !isLoggedIn ? const OnBoardingScreen() : const MyBottomNavigation(),
        routes: {
          // Add the routes here
          '/onboarding': (context) => const OnBoardingScreen(),
          '/get-info': (context) => const GetInfoScreen(),
          '/home': (context) => const MyBottomNavigation(),
        },
      ),
    );
  }
}
