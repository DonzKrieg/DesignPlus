import 'package:designplus/pages/cart_page.dart';
import 'package:designplus/pages/home_page.dart';
import 'package:designplus/pages/login_page.dart';
import 'package:designplus/pages/register_page.dart';
import 'package:designplus/pages/main_page.dart';
import 'package:designplus/pages/notification_page.dart';
import 'package:designplus/pages/onboarding_page.dart';
import 'package:designplus/pages/product_page.dart';
import 'package:designplus/pages/profile_page.dart';
import 'package:designplus/pages/splash_page.dart';
import 'package:designplus/pages/admin_product_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
  );

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
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/main': (context) => MainPage(),
        'home': (context) => HomePage(),
        '/admin': (context) => AdminProductPage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(),
        '/notification': (context) => const NotificationPage(),
        '/profile': (context) =>
            ProfilePage(isLightMode: true, onThemeChanged: (_) {}),
      },
    );
  }
}
