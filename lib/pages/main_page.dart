import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/cart_page.dart';
import 'package:designplus/pages/home_page.dart';
import 'package:designplus/pages/product_page.dart';
import 'package:designplus/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return ProductPage();
        case 2:
          return CartPage();
        case 3:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    Widget customBottomNav() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: kGreyColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kSecondaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: primaryTextStyle.copyWith(
            fontSize: 12,
            fontWeight: semiBold,
          ),
          unselectedLabelStyle: secondaryTextStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Produk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          buildContent(currentIndex),
          Align(alignment: Alignment.bottomCenter, child: customBottomNav()),
        ],
      ),
    );
  }
}
