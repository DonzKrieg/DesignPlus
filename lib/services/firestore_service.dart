import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designplus/pages/product_page.dart'; 

class FirestoreService {
  final CollectionReference _productsCollection = FirebaseFirestore.instance.collection('products');

  // = = = CREATE = = =
  Future<void> addProduct(Product product) {
    return _productsCollection.add(product.toMap());
  }

  // = = = READ = = =
  Stream<QuerySnapshot> getProduct() {
    return _productsCollection.snapshots();
  }

  // = = = UPDATE = = =
  Future<void> updateProduct(Product product) {
    return _productsCollection.doc(product.id).update(product.toMap());
  }

  // = = = DELETE = = =
  Future<void> deleteProduct(String id) {
    return _productsCollection.doc(id).delete();
  }
}