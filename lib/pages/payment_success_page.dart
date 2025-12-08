import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:intl/intl.dart';

class PaymentSuccessPage extends StatelessWidget {
  final double totalAmount;

  const PaymentSuccessPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSuccessIcon(),
            const SizedBox(height: 30),
            Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Terima kasih telah menyelesaikan pembayaran.\nPesanan kamu sedang kami proses.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kBlackColor, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Total Pembayaran',
              style: TextStyle(fontSize: 14, color: kBlackColor),
            ),
            const SizedBox(height: 6),
            Text(
              formatCurrency.format(totalAmount),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
            ),
            const SizedBox(height: 50),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              size: 80,
              color: kPrimaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ===== TOMBOL LIHAT STATUS PESANAN (TETAP SAMA) =====
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // masih statis
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 22),
                side: BorderSide(color: kPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Lihat Status Pesanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
