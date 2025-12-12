import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:designplus/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(
    text: '+62',
  );

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  String _gender = '';

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _subDistrictController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  bool _validateCurrentStep() {
    if (_currentIndex == 0) {
      // Step 1: Akun
      if (_emailController.text.isEmpty ||
          !_emailController.text.contains('@')) {
        _showError('Masukkan email yang valid.');
        return false;
      }
      if (_passwordController.text.length < 6) {
        _showError('Password minimal 6 karakter.');
        return false;
      }
      if (_phoneController.text.isEmpty) {
        _showError('Nomor telepon wajib diisi.');
        return false;
      }
    } else if (_currentIndex == 1) {
      // Step 2: Data Diri
      if (_firstNameController.text.isEmpty) {
        _showError('Nama depan wajib diisi.');
        return false;
      }
      if (_birthDateController.text.isEmpty) {
        _showError('Tanggal lahir wajib diisi.');
        return false;
      }
      if (_gender.isEmpty) {
        _showError('Pilih jenis kelamin.');
        return false;
      }
    } else if (_currentIndex == 2) {
      // Step 3: Alamat
      if (_addressController.text.isEmpty) {
        _showError('Alamat rumah wajib diisi.');
        return false;
      }
    }
    return true;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(msg)));
  }

  void _nextPage() async {
    if (_currentIndex < 3) {
      if (_validateCurrentStep()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      setState(() => _isLoading = true);
      try {
        await AuthService().signUp(
          email: _emailController.text,
          password: _passwordController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          city: _cityController.text,
          district: _districtController.text,
          subDistrict: _subDistrictController.text,
          zipCode: _zipCodeController.text,
          gender: _gender,
          birthDate: _birthDateController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Registrasi Berhasil!'),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        String msg = e.message ?? 'Gagal mendaftar.';
        if (e.code == 'email-already-in-use') msg = 'Email sudah terdaftar.';
        if (e.code == 'weak-password') msg = 'Password terlalu lemah.';
        _showError(msg);
      } catch (e) {
        _showError('Terjadi kesalahan: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

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

  Future<void> _selectDate(BuildContext context) async {
    // 1. Tampilkan Kalender
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: kPrimaryColor)),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate;

      try {
        await initializeDateFormatting('id_ID', null);
        formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(picked);
      } catch (e) {
        print("Gagal format Indo, pakai default: $e");
        formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      }

      setState(() {
        _birthDateController.text = formattedDate;

        print("Tanggal dipilih: ${_birthDateController.text}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = (_currentIndex + 1) / 4;

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _prevPage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    'Daftar Akun',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
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

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentIndex = index),
                children: [
                  _buildStep1Account(),
                  _buildStep2Personal(),
                  _buildStep3Address(),
                  _buildStep4Summary(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: CustomButton(
                text: _currentIndex == 3 ? 'Daftar Sekarang' : 'Lanjutkan',
                isLoading: _isLoading,
                onPressed: _nextPage,
                size: const Size(double.infinity, 54),
                color: const Color(0xFF2C40F0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Account() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Akun',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Data ini digunakan untuk masuk ke aplikasi.',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),
          _buildLabel('Email Address'),
          _buildCustomTextField(
            controller: _emailController,
            hint: 'nama@email.com',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildLabel('Password'),
          _buildCustomTextField(
            controller: _passwordController,
            hint: '••••••••',
            isObscure: true,
          ),
          const SizedBox(height: 16),
          _buildLabel('Nomor Telepon'),
          _buildCustomTextField(
            controller: _phoneController,
            hint: '+62812345678',
            inputType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Personal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Diri',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Lengkapi identitas diri Anda.',
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
          const SizedBox(height: 16),
          _buildLabel('Tanggal Lahir'),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _birthDateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              style: blackTextStyle.copyWith(fontWeight: semiBold),
              decoration: InputDecoration(
                hintText: 'Pilih Tanggal',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                suffixIcon: Icon(Icons.calendar_today, color: kGreyColor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildLabel('Jenis Kelamin'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _gender = 'Pria'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _gender == 'Pria'
                          ? Colors.blue.withOpacity(0.1)
                          : const Color(0xFFEDEEF5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _gender == 'Pria'
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.male,
                          color: _gender == 'Pria' ? Colors.blue : Colors.grey,
                          size: 40,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pria',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            color: _gender == 'Pria'
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _gender = 'Wanita'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _gender == 'Wanita'
                          ? Colors.pink.withOpacity(0.1)
                          : const Color(0xFFEDEEF5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _gender == 'Wanita'
                            ? Colors.pink
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.female,
                          color: _gender == 'Wanita'
                              ? Colors.pink
                              : Colors.grey,
                          size: 40,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Wanita',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            color: _gender == 'Wanita'
                                ? Colors.pink
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
            'Masukkan alamat pengiriman Anda.',
            style: greyTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 30),
          _buildLabel('Alamat Rumah'),
          _buildCustomTextField(
            controller: _addressController,
            hint: 'Jl. Mawar No. 1',
          ),
          const SizedBox(height: 16),
          _buildLabel('Kota'),
          _buildCustomTextField(
            controller: _cityController,
            hint: 'Jakarta Selatan',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Kecamatan'),
                    _buildCustomTextField(
                      controller: _subDistrictController,
                      hint: 'Tebet',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Kode Pos'),
                    _buildCustomTextField(
                      controller: _zipCodeController,
                      hint: '12810',
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLabel('Kelurahan'),
          _buildCustomTextField(
            controller: _districtController,
            hint: 'Tebet Barat',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

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
          const SizedBox(height: 30),
          _buildSummaryItem('Email', _emailController.text),
          _buildSummaryItem(
            'Nama',
            '${_firstNameController.text} ${_lastNameController.text}',
          ),
          _buildSummaryItem('Telepon', _phoneController.text),
          _buildSummaryItem(
            'Tgl Lahir / Gender',
            '${_birthDateController.text} (${_gender})',
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF2C40F0)),
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
                    fontSize: 15,
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: greyTextStyle),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: blackTextStyle.copyWith(fontWeight: semiBold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType inputType = TextInputType.text,
    bool isObscure = false,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDEEF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isObscure,
        style: blackTextStyle.copyWith(fontWeight: semiBold),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: greyTextStyle.copyWith(fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: icon != null ? Icon(icon, color: kGreyColor) : null,
        ),
      ),
    );
  }
}
