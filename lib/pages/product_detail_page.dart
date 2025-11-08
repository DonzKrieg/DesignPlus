import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/bottom_slider.dart';
import 'package:designplus/widgets/review_card.dart';
import 'package:designplus/widgets/variants.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final List<String> imgPath = [
    'assets/images/thumbnail.png',
    'assets/images/lanyard1.png',
    'assets/images/lanyard2.png',
    'assets/images/lanyard3.png',
    'assets/images/lanyard4.png',
    'assets/images/lanyard5.png',
  ];

  final List<String> gambarUlasan = [
    'assets/images/thumbnail.png',
    'assets/images/thumbnail.png',
    'assets/images/thumbnail.png',
    'assets/images/thumbnail.png',
    'assets/images/thumbnail.png',
  ];

  String selectedImage = 'assets/images/thumbnail.png';
  String selectedVariant = "ID Card";
  Icon iconFavorite = Icon(Icons.favorite_border);
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Widget productImage() {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(selectedImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                physics: ClampingScrollPhysics(),
                itemCount: imgPath.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImage = imgPath[index];
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: imgPath[index] == selectedImage
                            ? Border.all(color: kPrimaryColor, width: 2)
                            : null,
                        image: DecorationImage(
                          image: AssetImage(imgPath[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Card Panitia',
                      style: blackTextStyle.copyWith(
                        fontSize: 17,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      'Rp5.000',
                      style: primaryTextStyle.copyWith(
                        fontSize: 25,
                        fontWeight: black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Stok',
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '80.123',
                          style: secondaryTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Terjual',
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '32.000',
                          style: secondaryTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    iconColor: kSecondaryColor,
                    iconSize: 24,
                    backgroundColor: kWhiteColor,
                    elevation: 1,
                    shadowColor: kGreyColor,
                    shape: CircleBorder(),
                  ),
                  child: iconFavorite,
                  onPressed: () {
                    isFavorite = !isFavorite;
                    setState(() {
                      iconFavorite = Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? kNegativeColor : null,
                      );
                    });
                    isFavorite
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFFEBF4F1),
                              content: Row(
                                children: [
                                  Icon(Icons.check, color: kPositiveColor),
                                  SizedBox(width: 10),
                                  Text(
                                    'Berhasil ditambahkan ke wishlist',
                                    style: positiveTextStyle,
                                  ),
                                ],
                              ),
                              duration: Duration(milliseconds: 1800),
                            ),
                          )
                        : null;
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget ulasanSection() {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ulasan Produk',
                  style: blackTextStyle.copyWith(
                    fontSize: 17,
                    fontWeight: bold,
                  ),
                ),
                TextButton(
                  child: Text(
                    'Lihat Semua',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ReviewCard(
                  username: 'Ucup Markucup',
                  avatarImg: 'assets/images/budi.png',
                  reviewMsg:
                      'Wow barangnya sangat bagus dan recommended untuk dibeliiii',
                  reviewImg: [
                    'assets/images/review1.png',
                    'assets/images/review2.png',
                    'assets/images/review3.png',
                    'assets/images/review1.png',
                    'assets/images/review2.png',
                  ],
                ),
                ReviewCard(
                  username: 'Beben Silalahi',
                  avatarImg: 'assets/images/beben.png',
                  reviewMsg: 'Produknya keren pak xixixi',
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: kGreyColor,
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: kPrimaryColor),
            onPressed: () {
              // Handle chat button
            },
          ),
          IconButton(
            icon: Icon(Icons.share_outlined, color: kPrimaryColor),
            onPressed: () {
              // Handle share button
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket_outlined, color: kPrimaryColor),
            onPressed: () {
              // Handle cart button
            },
          ),
          SizedBox(width: 8), // Spacing at the end
        ],
      ),
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            productImage(),
            SizedBox(
              width: double.infinity,
              height: 5,
              child: Container(
                decoration: BoxDecoration(color: Color(0xFFE9EBFC)),
              ),
            ),
            ulasanSection(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: kPrimaryColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Tambah ke keranjang',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      builder: (context) => VariantBottomSheet(),
                    );
                  },
                  child: Text(
                    'Beli produk',
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
