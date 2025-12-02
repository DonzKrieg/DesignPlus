import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/pages/checkout.dart'; 

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      'image': 'assets/etalase_produk/id-card.jpeg',
      'name': 'ID Card + Lanyard',
      'price': 5000,
      'quantity': 2,
    },
    {
      'image': 'assets/etalase_produk/jersey.jpeg',
      'name': 'Kaos Cotton Combed',
      'price': 35000,
      'quantity': 1,
    },
    {
      'image': 'assets/etalase_produk/totebag.jpeg',
      'name': 'Custom Tote Bag',
      'price': 10000,
      'quantity': 3,
    },
  ];

  double shipping = 20000;

  // Hitung total semua produk
  double get subTotal {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  double get tax => subTotal * 0.15;
  double get total => subTotal + shipping + tax;

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      } else {
        // Bisa dihapus kalau quantity 0
        cartItems.removeAt(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Keranjang Saya',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),

            // ===== LIST PRODUK =====
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.asset(
                            item['image'],
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp${item['price']}',
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => decreaseQuantity(index),
                                      child: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      item['quantity'].toString(),
                                      style: blackTextStyle.copyWith(
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => increaseQuantity(index),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: kPrimaryColor,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => removeItem(index),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ===== RINGKASAN TOTAL =====
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom:
                    MediaQuery.of(context).padding.bottom +
                    70, // biar tidak ketutup nav
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryRow(
                    'Sub Total',
                    'Rp${subTotal.toStringAsFixed(0)}',
                  ),
                  _buildSummaryRow(
                    'Ongkir',
                    'Rp${shipping.toStringAsFixed(0)}',
                  ),
                  _buildSummaryRow(
                    'Pajak (15%)',
                    'Rp${tax.toStringAsFixed(0)}',
                  ),
                  const Divider(thickness: 0.5),
                  _buildSummaryRow(
                    'Total',
                    'Rp${total.toStringAsFixed(0)}',
                    isTotal: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Checkout berhasil! Total: Rp${total.toStringAsFixed(0)}',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isTotal
                ? blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold)
                : greyTextStyle.copyWith(fontSize: 13),
          ),
          Text(
            value,
            style: isTotal
                ? blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)
                : blackTextStyle.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CartPageState extends State<CartPage> {
  // ... (Kode variabel cartItems, shipping, subTotal, dll TETAP SAMA) ...
  
  // Note: Pastikan variabel ini ada di dalam class State
  List<Map<String, dynamic>> cartItems = [
    {
      'image': 'assets/etalase_produk/id-card.jpeg',
      'name': 'ID Card + Lanyard',
      'price': 5000,
      'quantity': 2,
    },
    {
      'image': 'assets/etalase_produk/jersey.jpeg',
      'name': 'Kaos Cotton Combed',
      'price': 35000,
      'quantity': 1,
    },
    {
      'image': 'assets/etalase_produk/totebag.jpeg',
      'name': 'Custom Tote Bag',
      'price': 10000,
      'quantity': 3,
    },
  ];

  double shipping = 5000; 

  double get subTotal => cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  double get tax => subTotal * 0.15;
  double get total => subTotal + shipping + tax;

  void increaseQuantity(int index) => setState(() => cartItems[index]['quantity']++);
  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      } else {
        cartItems.removeAt(index);
      }
    });
  }
  void removeItem(int index) => setState(() => cartItems.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Keranjang Saya',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      ),
      body: Column(
        children: [
          // ===== LIST PRODUK =====
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Text(
                      'Keranjang masih kosong',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      // ... (Kode tampilan item produk TETAP SAMA) ...
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                             BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                              child: Image.asset(item['image'], width: 90, height: 90, fit: BoxFit.cover,
                                errorBuilder: (ctx, err, _) => Container(width: 90, height: 90, color: Colors.grey[200], child: Icon(Icons.image)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['name'], style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    Text('Rp${item['price']}', style: primaryTextStyle.copyWith(fontSize: 14, fontWeight: semiBold)),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        GestureDetector(onTap: () => decreaseQuantity(index), child: Icon(Icons.remove_circle_outline, color: Colors.grey, size: 22)),
                                        Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('${item['quantity']}', style: blackTextStyle.copyWith(fontWeight: semiBold))),
                                        GestureDetector(onTap: () => increaseQuantity(index), child: Icon(Icons.add_circle, color: kPrimaryColor, size: 22)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(onPressed: () => removeItem(index), icon: Icon(Icons.close, color: Colors.grey, size: 20)),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // ===== BAGIAN YANG DIPERBAIKI (SUMMARY & BUTTON) =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow('Sub Total', 'Rp${subTotal.toStringAsFixed(0)}'),
                _buildSummaryRow('Pajak (15%)', 'Rp${tax.toStringAsFixed(0)}'),
                _buildSummaryRow('Estimasi Ongkir', 'Rp${shipping.toStringAsFixed(0)}'),
                const Divider(thickness: 0.5, height: 20),
                _buildSummaryRow('Total', 'Rp${total.toStringAsFixed(0)}', isTotal: true),
                
                const SizedBox(height: 20),
                
                // TOMBOL CHECKOUT
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  cartItems: cartItems,
                                  subtotal: subTotal,
                                  shipping: shipping,
                                  tax: tax,
                                  total: total,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Checkout',
                      style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
                    ),
                  ),
                ),
                
                // ===== PENTING: JARAK TAMBAHAN DI BAWAH =====
                // Tambahkan jarak ini agar tombol tidak tertutup Nav Bar
                const SizedBox(height: 80), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isTotal ? blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold) : greyTextStyle.copyWith(fontSize: 13)),
          Text(value, style: isTotal ? primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold) : blackTextStyle.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}