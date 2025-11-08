import 'package:designplus/pages/cart_page.dart';
import 'package:designplus/pages/home_page.dart';
import 'package:designplus/pages/login_page.dart';
import 'package:designplus/pages/main_page.dart';
import 'package:designplus/pages/onboarding_page.dart';
import 'package:designplus/pages/product_detail_page.dart';
import 'package:designplus/pages/product_page.dart';
import 'package:designplus/pages/profile_page.dart';
import 'package:designplus/pages/splash_page.dart';
import 'package:designplus/pages/notification_page.dart';
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
        '/': (context) => MainPage(),
        '/onboarding': (context) => OnboardingPage(),
        '/login': (context) => LoginPage(),
        '/main': (context) => MainPage(),
        'home': (context) => HomePage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(),
        '/profile': (context) => ProfilePage(),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}
