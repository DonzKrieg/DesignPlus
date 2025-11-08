import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = [
    'Semua',
    'Media Cetak',
    'Media Promosi',
    'Kaos',
    'Brosur',
  ];

  late String _selectedCategory;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _selectedCategory = filters[0];
    _filteredProducts = List.from(dummyProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======== HEADER ========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        'Ucup Markucup',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),

                  // ======== IKON NOTIFIKASI ========
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/notification');
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: kLightGreyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: kPrimaryColor,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: kWhiteColor, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                '4',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ======== SEARCH BAR ========
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kLightGreyColor, width: 1.2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Produk',
                    hintStyle: greyTextStyle.copyWith(fontSize: 14),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: kGreyColor),
                    contentPadding: const EdgeInsets.only(top: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ======== IMAGE BANNER ========
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/home/buku.png',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          'Gambar tidak ditemukan',
                          style: greyTextStyle,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // ======== CATEGORY FILTERS ========
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 12,
                  ),
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedCategory == filters[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text(filters[index]),
                        labelStyle: isSelected
                            ? primaryTextStyle.copyWith(fontWeight: medium)
                            : greyTextStyle.copyWith(fontWeight: regular),
                        backgroundColor: isSelected
                            ? kPrimaryColor.withOpacity(0.1)
                            : kLightGreyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? kPrimaryColor : kLightGreyColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = filters[index];
                            if (_selectedCategory == 'Semua') {
                              _filteredProducts = List.from(dummyProducts);
                            } else {
                              _filteredProducts = dummyProducts
                                  .where((p) => p.category == _selectedCategory)
                                  .toList();
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ======== PRODUK KAMI ========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Produk Kami',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Lihat Semua',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ======== GRID PRODUK ========
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = 2;
                  final spacing = 12.0;
                  final totalSpacing = (crossAxisCount - 1) * spacing;
                  final itemWidth =
                      (constraints.maxWidth - totalSpacing) / crossAxisCount;
                  final itemHeight = itemWidth * 1.55;
                  final aspectRatio = itemWidth / itemHeight;

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: _filteredProducts[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== MODEL PRODUK ========
class Product {
  final String imageUrl;
  final String name;
  final int price;
  final String stockInfo;
  final double rating;
  final String location;
  final String category;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.stockInfo,
    required this.rating,
    required this.location,
    required this.category,
  });
}

// ======== DUMMY DATA ========
final List<Product> dummyProducts = [
  Product(
    imageUrl: 'assets/etalase_produk/id-card.jpeg',
    name: 'ID Card + Lanyard',
    price: 5000,
    stockInfo: 'Stok 80rb+ • Terjual 20rb+',
    rating: 4.8,
    location: 'Kota Bandung',
    category: 'Media Promosi',
  ),
  Product(
    imageUrl: 'assets/etalase_produk/jersey.jpeg',
    name: 'Kaos Cotton Combed',
    price: 35000,
    stockInfo: 'Stok 55rb+ • Terjual 72rb+',
    rating: 4.3,
    location: 'Kota Administrasi Jakarta',
    category: 'Kaos',
  ),
  Product(
    imageUrl:
        'assets/etalase_produk/Furniture Store Bifold Brochure Template PSD, INDD.jpeg',
    name: 'Brosur Company Profile',
    price: 12000,
    stockInfo: 'Stok 100rb+ • Terjual 150rb+',
    rating: 5.0,
    location: 'Kab. Bandung',
    category: 'Brosur',
  ),
  Product(
    imageUrl: 'assets/etalase_produk/totebag.jpeg',
    name: 'Custom Tote Bag',
    price: 10000,
    stockInfo: 'Stok 80rb+ • Terjual 20rb+',
    rating: 4.8,
    location: 'Kota Bandung',
    category: 'Media Promosi',
  ),
  Product(
    imageUrl: 'assets/etalase_produk/id-card.jpeg',
    name: 'ID Card Premium',
    price: 8000,
    stockInfo: 'Stok 50rb+ • Terjual 10rb+',
    rating: 4.9,
    location: 'Kota Bandung',
    category: 'Media Promosi',
  ),
  Product(
    imageUrl: 'assets/etalase_produk/x-banner.jpeg',
    name: 'X-Banner Event',
    price: 75000,
    stockInfo: 'Stok 1rb+ • Terjual 500+',
    rating: 4.7,
    location: 'Jakarta Selatan',
    category: 'Media Promosi',
  ),
];

// ======== KARTU PRODUK (SUDAH DIMODIFIKASI) ========
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                product.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'Gambar tidak ditemukan',
                        style: greyTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp${product.price}',
                    style: primaryTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.stockInfo,
                    style: greyTextStyle.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating}',
                        style: greyTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          product.location,
                          style: greyTextStyle.copyWith(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== HALAMAN DETAIL PRODUK (Disertakan di sini untuk kelengkapan) ========
class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const Color kStarColor = Colors.amber;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Detail Produk',
          style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        automaticallyImplyLeading: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: kLightGreyColor, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        'Gambar tidak ditemukan',
                        style: greyTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rp${product.price} /pcs',
              style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            const SizedBox(height: 8),
            Text(product.stockInfo, style: greyTextStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star_rate_rounded, color: kStarColor),
                const SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 4),
                Text(product.location, style: greyTextStyle),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Deskripsi Produk',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Produk ini dibuat dengan bahan berkualitas tinggi dan dapat disesuaikan sesuai kebutuhan Anda. '
              'Kami menerima pesanan custom dengan desain Anda sendiri.',
              style: greyTextStyle.copyWith(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // logika penambahan ke keranjang
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.name} ditambahkan ke keranjang!',
                      ),
                    ),
                  );
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
