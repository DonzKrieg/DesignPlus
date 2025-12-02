import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/payment_success_page.dart';
import 'package:intl/intl.dart';

class PaymentDetailPage extends StatefulWidget {
  final double totalAmount;
  final String paymentMethod;

  const PaymentDetailPage({
    Key? key,
    required this.totalAmount,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  // ===================== STATE TIMER =====================
  Duration _remainingTime = const Duration(hours: 24);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    final String vaNumber = widget.paymentMethod == 'BCA'
        ? '8801234567890'
        : widget.paymentMethod == 'Mandiri'
            ? '9001234567890'
            : '089527819301';

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: kBlackColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Menunggu Pembayaran',
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // ===== 1. TOTAL TAGIHAN =====
              _buildSectionContainer(
                child: Column(
                  children: [
                    Text(
                      'Total Tagihan',
                      style: TextStyle(color: kGreyColor, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatCurrency.format(widget.totalAmount),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: kNegativeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: kNegativeColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Bayar dalam ${_formatDuration(_remainingTime)}',
                            style: TextStyle(
                              color: kNegativeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== 2. DETAIL PEMBAYARAN (VA / QR) =====
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.paymentMethod.contains('QRIS')
                              ? 'Scan QR Code'
                              : 'Nomor Virtual Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kBlackColor,
                          ),
                        ),
                        if (widget.paymentMethod == 'BCA')
                          Image.asset('assets/images/bca.png', height: 15)
                        else if (widget.paymentMethod == 'Mandiri')
                          Image.asset('assets/payment/mandiri.jpg', height: 15)
                      ],
                    ),
                    const Divider(height: 30),

                    if (widget.paymentMethod == 'QRIS')
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.asset(
                                'assets/payment/qris.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, error, stackTrace) =>
                                    Icon(Icons.qr_code_2,
                                        size: 150, color: kBlackColor),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Scan QR di atas dengan aplikasi pembayaran Anda',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: kGreyColor, fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Icon(Icons.account_balance,
                                      color: kPrimaryColor),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.paymentMethod,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      vaNumber,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: vaNumber));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Nomor VA berhasil disalin!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy,
                                  size: 18, color: kPrimaryColor),
                              label: Text(
                                'Salin Nomor',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: kPrimaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== 3. PETUNJUK PEMBAYARAN =====
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Petunjuk Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionStep(
                        1, 'Buka aplikasi M-Banking atau E-Wallet Anda.'),
                    _buildInstructionStep(2, 'Pilih menu Transfer / Bayar.'),
                    _buildInstructionStep(
                        3,
                        widget.paymentMethod == 'QRIS'
                            ? 'Scan QR Code yang tertera di atas.'
                            : 'Masukkan Nomor Virtual Account di atas.'),
                    _buildInstructionStep(4, 'Periksa detail tagihan Anda.'),
                    _buildInstructionStep(
                        5, 'Masukkan PIN dan pembayaran selesai.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentSuccessPage(
                    totalAmount: widget.totalAmount,
                  ),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cek Status Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInstructionStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: TextStyle(color: kGreyColor, fontSize: 13),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: kGreyColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}