import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designplus/models/user_model.dart';
import 'package:designplus/pages/edit_profile_field_page.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final bool isLightMode;
  final Function(bool) onThemeChanged;

  const ProfilePage({
    super.key,
    required this.isLightMode,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String username = '';
  String bio = '';
  String address = '';
  String phone = '';
  String email = '';
  String gender = '';
  String birthDate = '';

  bool _isLoading = true;
  late bool isLightMode;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    isLightMode = widget.isLightMode;
    fetchUserData();
  }

  // 2. Fungsi Ambil Data dari Firestore
  Future<void> fetchUserData() async {
    if (currentUser == null) return;

    try {
      // Di sini Anda memberi nama variabel 'userDoc'
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      // PERBAIKAN: Gunakan 'userDoc', bukan 'doc'
      if (userDoc.exists) {
        // PERBAIKAN: Gunakan 'userDoc' di sini juga
        UserModel user = UserModel.fromJson(
          userDoc.id,
          userDoc.data() as Map<String, dynamic>,
        );

        setState(() {
          name = user.fullName;
          username = user.username;
          bio = user.bio;
          address = user.address;
          phone = user.phone;
          email = user.email;
          gender = user.gender;
          birthDate = user.birthDate;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      setState(() => _isLoading = false);
    }
  }

  // 3. Fungsi Update Data ke Firestore (Dipanggil setelah edit)
  Future<void> updateFirestoreData(String field, String value) async {
    if (currentUser == null) return;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({field: value});

      // Jika field nama, update juga fullName untuk konsistensi
      if (field == 'firstName' || field == 'lastName') {
        // Logic tambahan jika diperlukan
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal update data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void showSuccessSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil telah diperbarui',
            style: TextStyle(color: kWhiteColor),
          ),
          backgroundColor: kPositiveColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(30),
          duration: Duration(milliseconds: 1500),
          action: SnackBarAction(
            label: 'Tutup',
            textColor: kWhiteColor,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }

    final pageBg = isLightMode ? Color(0xffE9EBFC) : Color(0xFF0B1220);
    final sectionBg = isLightMode ? kWhiteColor : Color(0xFF0F1720);
    final nameStyle = blackTextStyle.copyWith(
      fontSize: 17,
      fontWeight: semiBold,
      color: isLightMode ? kBlackColor : kWhiteColor,
    );
    final usernameStyle = greyTextStyle.copyWith(
      fontSize: 12,
      color: isLightMode ? null : Colors.grey[400],
    );
    final bioStyle = blackTextStyle.copyWith(
      fontSize: 12,
      color: isLightMode ? kBlackColor : Colors.grey[300],
    );

    Widget header() {
      return Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: MediaQuery.of(context).padding.top + 30,
          bottom: 24,
        ),
        margin: EdgeInsets.only(top: 0),
        color: sectionBg,
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
                  Text(name, style: nameStyle),
                  Text('@$username', style: usernameStyle),
                  SizedBox(height: 16),
                  Text(bio, style: bioStyle),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                isLightMode = !isLightMode;
                widget.onThemeChanged(isLightMode);
                setState(() {});
              },
              child: Container(
                width: 88,
                height: 44,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isLightMode ? Color(0xffE9EBFC) : Color(0xFF202732),
                ),
                child: AnimatedAlign(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  alignment: isLightMode
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Image.asset(
                      isLightMode
                          ? 'assets/images/icon_switch_dark.png'
                          : 'assets/images/icon_switch_light.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget orderStatus() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: sectionBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pesanan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
                color: isLightMode ? kBlackColor : kWhiteColor,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.payment,
                      color: isLightMode ? kBlackColor : kWhiteColor,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Bayar',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: isLightMode ? kBlackColor : Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: isLightMode ? kBlackColor : kWhiteColor,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Diproses',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: isLightMode ? kBlackColor : Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: isLightMode ? kBlackColor : kWhiteColor,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Dikirim',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: isLightMode ? kBlackColor : Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.check_box,
                      color: isLightMode ? kBlackColor : kWhiteColor,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pesanan Tiba',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: isLightMode ? kBlackColor : Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: isLightMode ? kBlackColor : kWhiteColor,
                      size: 24,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Disukai',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: isLightMode ? kBlackColor : Colors.grey[300],
                      ),
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
      if (_isLoading) return const Center(child: CircularProgressIndicator());

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: sectionBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info Profil',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
                color: isLightMode ? kBlackColor : kWhiteColor,
              ),
            ),
            SizedBox(height: 12),
            ProfileMenuItem(
              title: 'Nama',
              value: name,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
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
                  // Update UI Lokal
                  setState(() => name = result);
                  // Update ke Firestore (misal kita simpan ke field 'fullName')
                  updateFirestoreData('fullName', result);
                  showSuccessSnackBar();
                }
              },
            ),
            ProfileMenuItem(
              title: 'Username',
              textColor: isLightMode ? kBlackColor : kWhiteColor,
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
                  setState(() => username = result);
                  updateFirestoreData('username', result); // Update Firestore
                  showSuccessSnackBar();
                }
              },
            ),
            ProfileMenuItem(
              title: 'Bio',
              value: bio,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileFieldPage(
                      title: 'Bio',
                      initialValue: bio,
                      hint: 'Tulis bio singkat',
                      description: 'Deskripsi singkat diri Anda.',
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => bio = result);
                  updateFirestoreData('bio', result); // Update Firestore
                  showSuccessSnackBar();
                }
              },
            ),
          ],
        ),
      );
    }

    Widget personalInfo() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: sectionBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info Data Diri',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
                color: isLightMode ? kBlackColor : kWhiteColor,
              ),
            ),
            SizedBox(height: 12),
            ProfileMenuItem(
              title: 'Alamat',
              value: address,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
            ),
            ProfileMenuItem(
              title: 'No. Hp',
              value: phone,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
            ),
            ProfileMenuItem(
              title: 'Email',
              value: email,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
            ),
            ProfileMenuItem(
              title: 'Jenis Kelamin',
              value: gender,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
            ),
            ProfileMenuItem(
              title: 'Tanggal Lahir',
              value: birthDate,
              textColor: isLightMode ? kBlackColor : kWhiteColor,
            ),
          ],
        ),
      );
    }

    Widget logoutButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: sectionBg,
        child: TextButton(
          onPressed: () async {
            // Logic Logout Firebase
            await FirebaseAuth.instance.signOut();

            if (mounted) {
              // Kembali ke Login dan hapus semua stack navigasi
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/login', (route) => false);
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: isLightMode
                ? Colors.red.shade50
                : Colors.red.shade900.withOpacity(0.12),
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
      backgroundColor: pageBg,
      // Gunakan Loading Indicator jika data belum siap
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : ListView(
              padding: EdgeInsets.only(bottom: 105),
              children: [
                header(), // Pastikan di header() variabel 'name' & 'username' dipanggil
                SizedBox(height: 5),
                orderStatus(),
                SizedBox(height: 5),
                profileInfo(),
                SizedBox(height: 5),
                personalInfo(), // Pastikan personalInfo() memanggil var 'address', 'phone', dll
                SizedBox(height: 5),
                logoutButton(),
              ],
            ),
    );
  }
}
