import 'package:designplus/pages/edit_profile_field_page.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Ucup Markucup';
  String username = 'Ucupganz123';
  String bio = 'Bhapppzzz';
  String address = 'Jl. Sunny Ville No.5, Tangerang Selatan';
  String phone = '081298317182';
  String email = 'Ucupganz@gmail.com';
  String gender = 'Pria';
  String birthDate = '10 Januari 1992';

  @override
  Widget build(BuildContext context) {
    void _showSuccessSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil telah diperbarui',
            style: TextStyle(color: kBlackColor),
          ),
          backgroundColor: Color(0xffE9EBFC),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(30),
          duration: Duration(milliseconds: 1500),
        ),
      );
    }

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
            Stack(
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kWhiteColor,
                      border: Border.all(color: kPrimaryColor, width: 0.5),
                    ),
                    child: Icon(Icons.edit, color: kPrimaryColor, size: 16),
                  ),
                ),
              ],
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: blackTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@$username',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  Text(bio, style: blackTextStyle.copyWith(fontSize: 12)),
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
            ProfileMenuItem(
              title: 'Nama',
              value: name,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileFieldPage(
                      title: 'Nama',
                      initialValue: name,
                      hint: 'Masukkan nama asli',
                      description:
                          'Pakai nama asli untuk memudahkan verifikasi. Nama ini akan tampil di beberapa halaman.',
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    name = result;
                  });
                  _showSuccessSnackBar();
                }
              },
            ),
            ProfileMenuItem(
              title: 'Username',
              value: username,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileFieldPage(
                      title: 'Username',
                      initialValue: username,
                      hint: 'Masukkan username',
                      description:
                          'Username digunakan untuk login dan ditampilkan di profil Anda.',
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    username = result;
                  });
                  _showSuccessSnackBar();
                }
              },
            ),
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
              Icon(Icons.logout, color: kNegativeColor),
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
