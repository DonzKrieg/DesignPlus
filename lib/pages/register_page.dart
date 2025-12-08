import 'package:designplus/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Pastikan import ini sesuai dengan struktur project Anda
import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Page Controller untuk navigasi slide
  final PageController _pageController = PageController();

  // State untuk melacak halaman aktif (0, 1, 2, 3)
  int _currentIndex = 0;

  // Controllers - Agar data bisa diambil saat integrasi Firebase nanti
  final TextEditingController _phoneController = TextEditingController(
    text: '+62',
  );
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController =
      TextEditingController(); // Kelurahan
  final TextEditingController _subDistrictController =
      TextEditingController(); // Kecamatan
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _subDistrictController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  // Fungsi navigasi 'Lanjutkan'
  void _nextPage() async {
    // Ubah jadi async
    if (_currentIndex < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // === LOGIC REGISTER ===

      // Tampilkan Loading (bisa pakai dialog atau state button)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // Panggil Service
        await AuthService().signUp(
          email: "email_dari_input@gmail.com", // Ambil dari controller email
          password: "password123", // Ambil dari controller password
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          city: _cityController.text,
          district: _districtController.text,
          subDistrict: _subDistrictController.text,
          zipCode: _zipCodeController.text,
        );

        Navigator.pop(context); // Tutup loading dialog

        // Tampilkan Sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Registrasi Berhasil! Silakan Login.'),
          ),
        );

        // Arahkan ke Login atau Main Menu
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Tutup loading dialog
        String message = '';
        if (e.code == 'weak-password') {
          message = 'Password terlalu lemah.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Email sudah terdaftar.';
        } else {
          message = 'Gagal daftar: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(message)),
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text('Error: $e')),
        );
      }
    }
  }

  // Fungsi tombol Back (kiri atas)
  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung progress: 0->0.25, 1->0.50, dst
    double progressValue = (_currentIndex + 1) / 4;

    return Scaffold(
      backgroundColor: kWhiteColor, // Pastikan kWhiteColor ada di theme.dart
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER (Tombol Back, Judul, Progress) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: _prevPage,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFF1F4FF,
                        ), // Warna light blue background
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  // Title
                  Text(
                    'Daftar Akun',
                    style: primaryTextStyle.copyWith(
                      // Dari theme.dart
                      fontSize: 21,
                      fontWeight: bold,
                    ),
                  ),

                  // Progress Indicator Custom
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Lingkaran Progress
                        CircularProgressIndicator(
                          value: _currentIndex == 3 ? 1.0 : progressValue,
                          strokeWidth: 4,
                          backgroundColor: const Color(0xFFF1F4FF),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _currentIndex == 3
                                ? Colors.green
                                : const Color(0xFF5364F3),
                          ),
                        ),
                        // Text Persen atau Icon Centang
                        Center(
                          child: _currentIndex == 3
                              ? const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.green,
                                )
                              : Text(
                                  '${(progressValue * 100).toInt()}%',
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: bold,
                                    color: const Color(0xFF5364F3),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- FORM CONTENT (PageView) ---
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // User gak bisa swipe manual, harus klik tombol
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildStep1Phone(),
                  _buildStep2Name(),
                  _buildStep3Address(),
                  _buildStep4Summary(),
                ],
              ),
            ),

            // --- BOTTOM BUTTON ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: CustomButton(
                text: _currentIndex == 3 ? 'Daftar Sekarang' : 'Lanjutkan',
                onPressed: _nextPage,
                size: Size(double.infinity, 54),
                color: const Color(0xFF2C40F0), // Warna biru sesuai gambar
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HALAMAN 1: NOMOR TELEPON ---
  Widget _buildStep1Phone() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Telepon',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Masukkan nomor telepon yang berlaku untuk menerima notifikasi pemesanan Anda.',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),
          _buildCustomTextField(
            controller: _phoneController,
            hint: '+62812345678',
            inputType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  // --- HALAMAN 2: NAMA LENGKAP ---
  Widget _buildStep2Name() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Lengkap',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Isi formulir di bawah sesuai dengan nama lengkap Anda.',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),
          _buildLabel('Nama Depan'),
          _buildCustomTextField(
            controller: _firstNameController,
            hint: 'Contoh: Ucup',
          ),
          const SizedBox(height: 16),
          _buildLabel('Nama Belakang'),
          _buildCustomTextField(
            controller: _lastNameController,
            hint: 'Contoh: Markucup',
          ),
        ],
      ),
    );
  }

  // --- HALAMAN 3: ALAMAT LENGKAP ---
  Widget _buildStep3Address() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alamat Lengkap',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Masukkan alamat tempat tinggal Anda agar pesanan sampai sesuai tujuan.',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),
          _buildLabel('Alamat Rumah'),
          _buildCustomTextField(
            controller: _addressController,
            hint: 'Contoh: Jl. Sunny Ville No.5',
          ),
          const SizedBox(height: 16),
          _buildLabel('Kota'),
          _buildCustomTextField(
            controller: _cityController,
            hint: 'Contoh: Tangerang Selatan',
          ),
          const SizedBox(height: 16),
          _buildLabel('Kelurahan'),
          _buildCustomTextField(
            controller: _districtController,
            hint: 'Contoh: Buaran',
          ),
          const SizedBox(height: 16),
          _buildLabel('Kecamatan'),
          _buildCustomTextField(
            controller: _subDistrictController,
            hint: 'Contoh: Serpong Utara',
          ),
          const SizedBox(height: 16),
          _buildLabel('Kode Pos'),
          _buildCustomTextField(
            controller: _zipCodeController,
            hint: 'Contoh: 15322',
            inputType: TextInputType.number,
          ),
          const SizedBox(height: 20), // Extra space for scroll
        ],
      ),
    );
  }

  // --- HALAMAN 4: RINGKASAN AKUN ---
  Widget _buildStep4Summary() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Akun',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Pastikan data yang tertera sesuai dengan data diri pribadi Anda',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),

          // Kartu Nama
          _buildSummaryCard(
            label: 'Nama Lengkap',
            value: '${_firstNameController.text} ${_lastNameController.text}',
          ),
          const SizedBox(height: 16),

          // Kartu Telepon
          _buildSummaryCard(
            label: 'Nomor Telepon',
            value: _phoneController.text,
          ),
          const SizedBox(height: 16),

          // Kartu Alamat (Multi-line)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF2C40F0)), // Blue Border
              borderRadius: BorderRadius.circular(12),
              color: kWhiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Lengkap',
                  style: greyTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_addressController.text}, ${_districtController.text}, ${_subDistrictController.text}\n${_cityController.text} ${_zipCodeController.text}',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
      ),
    );
  }

  // Text Field dengan style background abu-abu seperti gambar 1-3
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDEEF5), // Light gray background
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: blackTextStyle.copyWith(fontWeight: semiBold),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: greyTextStyle.copyWith(fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Card Ringkasan dengan border biru (Halaman 4)
  Widget _buildSummaryCard({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2C40F0)), // Blue Border
        borderRadius: BorderRadius.circular(12),
        color: kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: greyTextStyle.copyWith(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value, // Handle empty state
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
        ],
      ),
    );
  }
}
