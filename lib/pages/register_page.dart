import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subDistrictController = TextEditingController();
  final TextEditingController postalController = TextEditingController();

  void nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      _buildPhoneStep(),
      _buildNameStep(),
      _buildAddressStep(),
      _buildSummaryStep(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: previousStep,
        ),
        title: Text(
          'Daftar Akun',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1565FF),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              currentStep == 3 ? Icons.check_circle : Icons.close,
              color: const Color(0xFF1565FF),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: steps[currentStep]),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: nextStep,
                child: Text(
                  'Lanjutkan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Step 1: Nomor Telepon ===
  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomor Telepon',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Masukkan nomor telepon yang berlaku untuk menerima notifikasi pemesanan Anda.',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('+6281234567890'),
        ),
      ],
    );
  }

  // === Step 2: Nama Lengkap ===
  Widget _buildNameStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama Lengkap',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Isi form di bawah sesuai dengan nama lengkap Anda.',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: firstNameController,
          decoration: _inputDecoration('Nama Depan'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: lastNameController,
          decoration: _inputDecoration('Nama Belakang'),
        ),
      ],
    );
  }

  // === Step 3: Alamat Lengkap ===
  Widget _buildAddressStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat Lengkap',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Masukkan alamat tempat tinggal Anda agar pesanan sampai sesuai tujuan.',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: addressController,
          decoration: _inputDecoration('Alamat Rumah'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: cityController,
          decoration: _inputDecoration('Kota'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: subDistrictController,
          decoration: _inputDecoration('Kelurahan'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: districtController,
          decoration: _inputDecoration('Kecamatan'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: postalController,
          decoration: _inputDecoration('Kode Pos'),
        ),
      ],
    );
  }

  // === Step 4: Ringkasan Akun ===
  Widget _buildSummaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Akun',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Pastikan data yang tertera sesuai dengan identitas Anda.',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        _summaryBox(
          title: 'Nama Lengkap',
          value: '${firstNameController.text} ${lastNameController.text}'
              .trim(),
        ),
        const SizedBox(height: 12),
        _summaryBox(title: 'Nomor Telepon', value: phoneController.text),
        const SizedBox(height: 12),
        _summaryBox(
          title: 'Alamat Lengkap',
          value:
              '${addressController.text}, ${subDistrictController.text}, ${districtController.text}, ${cityController.text} ${postalController.text}'
                  .trim(),
        ),
      ],
    );
  }

  // === UI Helpers ===
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _summaryBox({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value.isEmpty ? '-' : value,
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
