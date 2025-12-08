import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Size size;
  final VoidCallback onPressed;
  final Color color;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.size,
    required this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // 1. Jika isLoading true, onPressed di-set null (tombol disable/tidak bisa diklik)
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        // 2. Agar saat loading (disabled) warnanya tidak jadi abu-abu default,
        // kita buat warnanya tetap sama tapi agak transparan
        disabledBackgroundColor: color.withOpacity(0.7),
        disabledForegroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: size,
      ),
      // 3. Logika tampilan: Tampilkan Loading Indicator jika isLoading true
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white, // Warna putaran loading
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: whiteTextStyle.copyWith(
                fontSize: 17,
                fontWeight: semiBold,
              ),
            ),
    );
  }
}
