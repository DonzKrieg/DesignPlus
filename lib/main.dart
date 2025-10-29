import '../pages/product_page.dart'; 
// import 'package:designplus/pages/splash_page.dart'; // Splash page tidak dipanggil dulu
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
      home: ProductPage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SplashPage(), 
      //   '/product': (context) => ProductPage(),
      // },
    );
  }
}

