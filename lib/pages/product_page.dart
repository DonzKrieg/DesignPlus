import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/bottom_nav.dart';

// = = = = = = = = = = = = = CONFIG = = = = = = = = = = = = =
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

//  = = = = = = = = = = = = = DUMMY DATA = = = = = = = = = = = = =
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

//  = = = = = = = = = = = = = PRODUCT PAGE WIDGET = = = = = = = = = = = = =
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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

  int _calculateCurrentIndex(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/product':
        return 1;
      case '/cart':
        return 2;
      case '/profile':
        return 3;
      default:
        if (currentRoute == '/') {
          return 1;
        }
        return 1;
    }
  }

  // void _onItemTapped(int index) {
  //   final String? currentRoute = ModalRoute.of(context)?.settings.name;

  //   switch (index) {
  //     case 0: // Beranda
  //       if (currentRoute != '/home') {
  //         Navigator.pushReplacementNamed(context, '/home');
  //       }
  //       break;
  //     case 1: // Produk
  //       if (currentRoute != '/product') {
  //         Navigator.pushReplacementNamed(context, '/product');
  //       }
  //       break;
  //     case 2: // Keranjang
  //       if (currentRoute != '/cart') {
  //         Navigator.pushReplacementNamed(context, '/cart');
  //       }
  //       break;
  //     case 3: // Profile
  //       if (currentRoute != '/profile') {
  //         Navigator.pushReplacementNamed(context, '/profile');
  //       }
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _calculateCurrentIndex(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex, 
        // onTap: _onItemTapped, 
      ),
    );
  }

  // = = = = = = = = = = = = = WIDGET UNTUK APPBAR = = = = = = = = = = = = =
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: kWhiteColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: kBlackColor, size: 20),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        'Etalase Produk',
        style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
      ),
    );
  }

  // = = = = = = = = = = = = = WIDGET UNTUK BODY = = = = = = = = = = = = =
  Widget buildBody() {
    return Column(
      children: [
        buildFilterChips(),
        Expanded(
          child: _filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'Produk untuk kategori ini belum tersedia',
                    style: greyTextStyle.copyWith(fontSize: 16),
                  ),
                )
              : buildProductGrid(),
        ),
      ],
    );
  }

  // = = = = = = = = = = = = = WIDGET UNTUK FILTER CHIPS = = = = = = = = = = = = =
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

                  if (_selectedCategory == 'Semua') {
                    _filteredProducts = List.from(dummyProducts);
                  } else {
                    _filteredProducts = dummyProducts
                        .where(
                          (product) => product.category == _selectedCategory,
                        )
                        .toList();
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

  // = = = = = = = = = = = = = WIDGET UNTUK GRID PRODUK = = = = = = = = = = = = =
  Widget buildProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: _filteredProducts[index]);
      },
    );
  }
}

// = = = = = = = = = = = = = PRODUCT CARD WIDGET = = = = = = = = = = = = =
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              product.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                    Icon(Icons.star_rate_rounded, color: kStarColor, size: 16),
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
    );
  }
}
