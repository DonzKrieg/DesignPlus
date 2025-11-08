import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class VariantBottomSheet extends StatefulWidget {
  const VariantBottomSheet({super.key});

  @override
  State<VariantBottomSheet> createState() => _VariantBottomSheetState();
}

class _VariantBottomSheetState extends State<VariantBottomSheet> {
  String selectedVariant = "ID Card Only";

  final List<Map<String, dynamic>> variants = [
    {"name": "ID Card Only", "image": "assets/images/lanyard1.png"},
    {"name": "Lanyard Only", "image": "assets/images/lanyard2.png"},
    {"name": "ID Card + Lanyard", "image": "assets/images/lanyard3.png"},
    {"name": "ID Card + Frame Card", "image": "assets/images/lanyard4.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(height: 10),
          Text(
            "Varian Produk",
            style: blackTextStyle.copyWith(fontSize: 17, fontWeight: bold),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Container(
                height: 100,
                width: 100,
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
                    selectedVariant,
                    style: blackTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Rp5.000",
                        style: primaryTextStyle.copyWith(
                          fontSize: 21,
                          fontWeight: black,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "/pcs",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kNegativeColor,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFFCE9E9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        '3 Kupon tersedia',
                        style: negativeTextStyle.copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Pilih Varian:",
            style: blackTextStyle.copyWith(fontSize: 17, fontWeight: bold),
          ),
          const SizedBox(height: 8),

          // Daftar Varian
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: variants.map((variant) {
              bool isSelected = selectedVariant == variant["name"];
              return GestureDetector(
                onTap: () {
                  setState(() => selectedVariant = variant["name"]);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? kPrimaryColor : kGreyColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(variant["image"]),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        variant["name"],
                        style: TextStyle(
                          color: isSelected ? kPrimaryColor : kGreyColor,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.pop(context, selectedVariant);
              },
              child: Text(
                "Konfirmasi Pesanan",
                style: whiteTextStyle.copyWith(fontWeight: bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
