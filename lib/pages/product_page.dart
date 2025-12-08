import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/product_detail_page.dart';
import 'package:designplus/services/firestore_service.dart';

// = = = = = = = = = = = = = MODEL PRODUCT  = = = = = = = = = = = = =
class Product {
  final String id; 
  final String imageUrl;
  final String name;
  final int price;
  final String stockInfo;
  final double rating;
  final String location;
  final String category;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.stockInfo,
    required this.rating,
    required this.location,
    required this.category,
  });

  factory Product.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? 'No Name',
      price: data['price'] ?? 0,
      stockInfo: data['stockInfo'] ?? 'Ready',
      rating: (data['rating'] ?? 0.0).toDouble(),
      location: data['location'] ?? '-',
      category: data['category'] ?? 'Uncategorized',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'stockInfo': stockInfo,
      'rating': rating,
      'location': location,
      'category': category,
    };
  }
}

// = = = = = = = = = = = = = PRODUCT PAGE WIDGET = = = = = = = = = = = = =
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Instance dari Service Firestore
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> filters = [
    'Semua',
    'Media Cetak',
    'Media Promosi',
    'Kaos',
    'Brosur',
  ];

  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  // = = = APP BAR = = =
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: kWhiteColor,
      elevation: 2,
      centerTitle: true,
      title: Text(
        'Etalase Produk',
        style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
      ),
      automaticallyImplyLeading: false,
      shape: Border(bottom: BorderSide(color: kLightGreyColor, width: 1)),
    );
  }

  // = = = BODY = = =
  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          buildFilterChips(),
          Expanded(
            // Menggunakan StreamBuilder untuk data real-time
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getProduct(), // Panggil method dari service
              builder: (context, snapshot) {
                // 1. Cek status loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // 2. Cek jika ada error
                if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan memuat data'));
                }

                // 3. Cek jika data kosong
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'Belum ada produk tersimpan',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  );
                }

                // 4. Konversi data snapshot ke List<Product>
                List<Product> allProducts = snapshot.data!.docs.map((doc) {
                  return Product.fromSnapshot(doc);
                }).toList();

                // 5. Filter data berdasarkan kategori yang dipilih
                List<Product> filteredProducts;
                if (_selectedCategory == 'Semua') {
                  filteredProducts = allProducts;
                } else {
                  filteredProducts = allProducts
                      .where((p) => p.category == _selectedCategory)
                      .toList();
                }

                // 6. Tampilkan pesan jika hasil filter kosong
                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Text(
                      'Produk untuk kategori ini belum tersedia',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  );
                }

                // 7. Tampilkan Grid
                return buildProductGrid(filteredProducts);
              },
            ),
          ),
        ],
      ),
    );
  }

  // = = = FILTER CHIPS = = =
  Widget buildFilterChips() {
    return Container(
      height: 60,
      color: kWhiteColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedCategory == filters[index];

          return Padding(
            padding: EdgeInsets.only(right: 8),
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
                  // SetState akan memicu rebuild, dan StreamBuilder
                  // akan menjalankan logika filternya lagi.
                });
              },
            ),
          );
        },
      ),
    );
  }

  // = = = GRID PRODUK = = =
  // Sekarang menerima parameter List<Product> hasil filter
  Widget buildProductGrid(List<Product> products) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

// = = = = = = = PRODUCT CARD = = = = = = =
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke detail page (pastikan ProductDetailPage menerima parameter product jika perlu)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailPage()),
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
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // = = = IMAGE HANDLER = = =
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: _buildImage(product.imageUrl),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Rp${product.price}',
                        style: primaryTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text('/pcs', style: greyTextStyle.copyWith(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.stockInfo,
                    style: greyTextStyle.copyWith(fontSize: 10),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: kStarColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: kGreyColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
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

  // Helper untuk menentukan apakah gambar dari Network atau Asset
  Widget _buildImage(String url) {
    // Jika URL dimulai dengan http/https, load dari internet
    if (url.startsWith('http')) {
      return Image.network(
        url,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Placeholder jika gambar gagal dimuat
          return Container(
            height: 150,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 150,
            color: Colors.grey[100],
            child: Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
    // Jika tidak, asumsikan asset lokal
    return Image.asset(
      url,
      height: 150,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 150,
          color: Colors.grey[300],
          child: Icon(Icons.image_not_supported, color: Colors.grey),
        );
      },
    );
  }
}