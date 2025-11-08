import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/product_page.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Detail Produk',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true, 
        shape: Border(
          bottom: BorderSide(color: kLightGreyColor, width: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(product.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rp${product.price} /pcs',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 8),
            Text(product.stockInfo, style: greyTextStyle),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star_rate_rounded, color: kStarColor),
                SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: kGreyColor),
                SizedBox(width: 4),
                Text(product.location, style: greyTextStyle),
              ],
            ),
            SizedBox(height: 24),
            Divider(color: kLightGreyColor),
            SizedBox(height: 16),
            Text(
              'Deskripsi Produk',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Produk ini dibuat dengan bahan berkualitas tinggi dan dapat disesuaikan sesuai kebutuhan Anda. '
              'Kami menerima pesanan custom dengan desain Anda sendiri.',
              style: greyTextStyle.copyWith(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // logika penambahan ke keranjang
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Tambah ke Keranjang',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
