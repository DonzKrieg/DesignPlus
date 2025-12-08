import 'package:designplus/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  bool _remember = false;
  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 320,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/login_background.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kWhiteColor, kWhiteColor.withOpacity(0.0)],
                        stops: const [0.0, 0.6],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Selamat Datang',
                    style: primaryTextStyle.copyWith(
                      fontSize: 25,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Masuk dengan akun Anda, atau pilih\nmetode masuk yang tersedia',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Username',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _userCtrl,
                    decoration: InputDecoration(
                      hintText: 'John Doe',
                      hintStyle: greyTextStyle.copyWith(fontWeight: semiBold),
                      filled: true,
                      fillColor: kSecondaryColor.withOpacity(0.18),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Password',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: greyTextStyle.copyWith(fontWeight: semiBold),
                      filled: true,
                      fillColor: kSecondaryColor.withOpacity(0.18),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: kGreyColor,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _remember = !_remember),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: kLightGreyColor),
                            color: _remember ? kPrimaryColor : kWhiteColor,
                          ),
                          child: _remember
                              ? Icon(Icons.check, size: 16, color: kWhiteColor)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Ingat Saya pada perangkat ini',
                          style: greyTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Lupa Password?',
                        style: primaryTextStyle.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Masuk',
                    isLoading:
                        _isLoading, // Asumsi CustomButton support loading, jika tidak, pakai Stack/Indicator
                    onPressed: () async {
                      // Validasi input kosong
                      if (_userCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Email dan Password harus diisi!'),
                          ),
                        );
                        return;
                      }

                      setState(() => _isLoading = true); // Mulai loading

                      try {
                        // Panggil Auth Service (Gunakan email controller sbg username/email)
                        // Pastikan _userCtrl inputnya adalah Email format, atau tambahkan logic handling
                        await AuthService().signIn(
                          email: _userCtrl.text,
                          password: _passCtrl.text,
                        );

                        // Jika sukses, redirect
                        if (mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/main',
                            (route) => false,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        String message = '';
                        if (e.code == 'user-not-found') {
                          message = 'Pengguna tidak ditemukan.';
                        } else if (e.code == 'wrong-password') {
                          message = 'Password salah.';
                        } else {
                          message = 'Terjadi kesalahan: ${e.message}';
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(message),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Gagal masuk: $e'),
                            ),
                          );
                        }
                      } finally {
                        if (mounted)
                          setState(() => _isLoading = false); // Stop loading
                      }
                    },
                    size: Size(screenW, 54),
                    color: kPrimaryColor,
                  ),
                  const SizedBox(height: 21),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: kLightGreyColor, thickness: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Atau', style: greyTextStyle),
                      ),
                      Expanded(
                        child: Divider(color: kLightGreyColor, thickness: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: kGreyColor.withOpacity(0.6),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            height: 24,
                            width: 24,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.g_mobiledata,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Masuk dengan Google',
                            style: blackTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: greyTextStyle.copyWith(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Daftar',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
