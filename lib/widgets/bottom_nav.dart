import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  // final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      // onTap: onTap,
      backgroundColor: kWhiteColor,
      type: BottomNavigationBarType.fixed, 
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kGreyColor,
      selectedLabelStyle: primaryTextStyle.copyWith(
        fontSize: 12,
        fontWeight: medium,
      ),
      unselectedLabelStyle: greyTextStyle.copyWith(
        fontSize: 12,
        fontWeight: regular,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view_rounded),
          label: 'Produk',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
