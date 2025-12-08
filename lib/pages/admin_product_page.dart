import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/services/firestore_service.dart';
// Sesuaikan import ini dengan lokasi model Product Anda
import 'package:designplus/pages/product_page.dart'; 
import 'package:designplus/pages/product_form_page.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Kelola Produk', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold)),
        backgroundColor: kWhiteColor,
        elevation: 1,
        iconTheme: IconThemeData(color: kBlackColor),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add, color: kWhiteColor),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductFormPage()),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Belum ada data produk"));
          }

          List<Product> products = snapshot.data!.docs.map((doc) {
            return Product.fromSnapshot(doc);
          }).toList();

          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = products[index];
              return Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.imageUrl.startsWith('http')
                        ? Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                        : Container(width: 50, height: 50, color: Colors.grey[300], child: Icon(Icons.image)),
                  ),
                  title: Text(item.name, style: blackTextStyle.copyWith(fontWeight: medium)),
                  subtitle: Text('Rp${item.price} • ${item.category}', style: greyTextStyle.copyWith(fontSize: 12)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Hapus Produk?"),
                          content: Text("Yakin ingin menghapus ${item.name}?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Batal")),
                            TextButton(
                              onPressed: () {
                                _firestoreService.deleteProduct(item.id);
                                Navigator.pop(ctx);
                              },
                              child: Text("Hapus", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductFormPage(product: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}