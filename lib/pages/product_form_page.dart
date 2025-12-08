import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';
import 'package:designplus/services/firestore_service.dart';
import 'package:designplus/pages/product_page.dart'; 

class ProductFormPage extends StatefulWidget {
  final Product? product; 

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _ratingController;
  late TextEditingController _locationController;
  late TextEditingController _imageUrlController;
  
  String? _selectedCategory;
  final List<String> _categories = [
    'Media Cetak', 'Media Promosi', 'Kaos', 'Brosur'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _stockController = TextEditingController(text: widget.product?.stockInfo ?? 'Stok Banyak');
    _ratingController = TextEditingController(text: widget.product?.rating.toString() ?? '4.5');
    _locationController = TextEditingController(text: widget.product?.location ?? 'Kota Bandung');
    _imageUrlController = TextEditingController(text: widget.product?.imageUrl ?? '');
    
    if (widget.product != null && _categories.contains(widget.product!.category)) {
      _selectedCategory = widget.product!.category;
    } else {
      _selectedCategory = _categories.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _ratingController.dispose();
    _locationController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.product != null;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
        backgroundColor: kWhiteColor,
        elevation: 1,
        iconTheme: IconThemeData(color: kBlackColor),
        titleTextStyle: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Nama Produk", _nameController),
              _buildTextField("Harga (Angka)", _priceController, isNumber: true),
              _buildDropdown(),
              _buildTextField("Info Stok", _stockController),
              _buildTextField("Rating (1.0 - 5.0)", _ratingController, isNumber: true),
              _buildTextField("Lokasi", _locationController),
              _buildTextField("Image URL (Link Gambar)", _imageUrlController),
              
              SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _saveProduct,
                  child: Text(
                    isEdit ? 'Update Produk' : 'Simpan Produk',
                    style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: kWhiteColor,
        ),
        validator: (value) => value == null || value.isEmpty ? 'Harap isi $label' : null,
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        items: _categories.map((cat) {
          return DropdownMenuItem(value: cat, child: Text(cat));
        }).toList(),
        onChanged: (val) => setState(() => _selectedCategory = val),
        decoration: InputDecoration(
          labelText: 'Kategori',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: kWhiteColor,
        ),
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final int price = int.tryParse(_priceController.text) ?? 0;
      final String stock = _stockController.text;
      final double rating = double.tryParse(_ratingController.text) ?? 0.0;
      final String location = _locationController.text;
      final String imageUrl = _imageUrlController.text;
      final String category = _selectedCategory ?? 'Lainnya';

      Product newProduct = Product(
        id: widget.product?.id ?? '', 
        imageUrl: imageUrl,
        name: name,
        price: price,
        stockInfo: stock,
        rating: rating,
        location: location,
        category: category,
      );

      if (widget.product == null) {
        _firestoreService.addProduct(newProduct).then((_) {
           Navigator.pop(context); 
        });
      } else {
        _firestoreService.updateProduct(newProduct).then((_) {
           Navigator.pop(context); 
        });
      }
    }
  }
}