import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: MediaQuery.of(context).padding.top + 30,
          bottom: 24,
        ),
        margin: EdgeInsets.only(top: 0),
        color: kWhiteColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/img_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ucup Markucup',
                    style: blackTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '@Ucupganz123',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Bhapppzzz',
                    style: blackTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 88,
              height: 44,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xffE9EBFC),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/icon_switch_dark.png'),
              ),
            ),
          ],
        ),
      );
    }

    Widget orderStatus() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: kWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pesanan',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.payment, color: kBlackColor, size: 24),
                    SizedBox(height: 5),
                    Text('Bayar', style: blackTextStyle.copyWith(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.access_time, color: kBlackColor, size: 24),
                    SizedBox(height: 5),
                    Text(
                      'Diproses',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_shipping, color: kBlackColor, size: 24),
                    SizedBox(height: 5),
                    Text(
                      'Dikirim',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.check_box, color: kBlackColor, size: 24),
                    SizedBox(height: 5),
                    Text(
                      'Pesanan Tiba',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.favorite_border, color: kBlackColor, size: 24),
                    SizedBox(height: 5),
                    Text(
                      'Disukai',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    }

    Widget profileInfo() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: kWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info Profil',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            SizedBox(height: 12),
            ProfileMenuItem(title: 'Nama', value: 'Ucup Markucup'),
            ProfileMenuItem(title: 'Username', value: 'Ucupganz123'),
            ProfileMenuItem(title: 'Bio', value: 'Bhapppzzz'),
          ],
        ),
      );
    }

    Widget personalInfo() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: kWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info Data Diri',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            SizedBox(height: 12),
            ProfileMenuItem(
              title: 'Alamat',
              value: 'Jl. Sunny Ville No.5, Tangerang Selatan',
            ),
            ProfileMenuItem(title: 'No. Hp', value: '081298317182'),
            ProfileMenuItem(title: 'Email', value: 'Ucupganz@gmail.com'),
            ProfileMenuItem(title: 'Jenis Kelamin', value: 'Pria'),
            ProfileMenuItem(title: 'Tanggal Lahir', value: '10 Januari 1992'),
          ],
        ),
      );
    }

    Widget logoutButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: kWhiteColor,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: kNegativeColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Keluar',
                style: TextStyle(
                  color: kNegativeColor,
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.logout, color: Colors.red),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffE9EBFC),
      body: ListView(
        padding: EdgeInsets.only(bottom: 105),
        children: [
          header(),
          SizedBox(height: 5),
          orderStatus(),
          SizedBox(height: 5),
          profileInfo(),
          SizedBox(height: 5),
          personalInfo(),
          SizedBox(height: 5),
          logoutButton(),
        ],
      ),
    );
  }
}
