import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class BottomSlider extends StatefulWidget {
  const BottomSlider({super.key});

  @override
  State<BottomSlider> createState() => _BottomSliderState();
}

class _BottomSliderState extends State<BottomSlider> {
  final List<VariantOptions> options = [
    VariantOptions(
      imgPath: 'assets/images/onboarding1.png',
      titleOption: 'ID Card Only',
    ),
    VariantOptions(
      imgPath: 'assets/images/onboarding2.png',
      titleOption: 'Lanyard Only',
    ),
    VariantOptions(
      imgPath: 'assets/images/onboarding3.png',
      titleOption: 'ID Card + Lanyard',
    ),
    VariantOptions(
      imgPath: 'assets/images/onboarding1.png',
      titleOption: 'ID Card + Frame Card',
    ),
  ];

  @override
  Widget build(context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xd9d9d9d9),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Varian Produk',
              style: blackTextStyle.copyWith(fontSize: 17, fontWeight: bold),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/onboarding1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Card Panitia',
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Rp5.000',
                      style: primaryTextStyle.copyWith(
                        fontSize: 21,
                        fontWeight: bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kNegativeColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFFCE9E9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Text(
                          '3 Kupon Tersedia',
                          style: negativeTextStyle.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Pilih Varian:',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'ID Card Only',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class VariantOptions extends StatelessWidget {
  final String imgPath;
  final String titleOption;

  const VariantOptions({
    super.key,
    required this.imgPath,
    required this.titleOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kSecondaryColor,
          style: BorderStyle.solid,
          width: 1,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(radius: 14, backgroundImage: AssetImage(imgPath)),
            SizedBox(width: 10),
            Text(titleOption, style: secondaryTextStyle.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
