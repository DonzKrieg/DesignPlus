// import 'package:designplus/pages/login_page.dart';
import 'package:designplus/pages/onboarding_page.dart';
import 'package:designplus/pages/product_page.dart';
import 'package:designplus/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/onboarding': (context) => OnboardingPage(),
        // '/login': (context) => LoginPage(),
        '/product': (context) =>  ProductPage(),
    },
    );
  }
}
