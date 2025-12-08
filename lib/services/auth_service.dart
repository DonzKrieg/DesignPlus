import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String city,
    required String district,
    required String subDistrict,
    required String zipCode,
  }) async {
    try {
      // 1. Buat akun di Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // 2. Simpan data detail ke Firestore
      // Kita pakai Map manual di sini supaya cepat, tidak perlu instansiasi UserModel dulu
      await _firestore.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'fullName': '$firstName $lastName',
        'phone': phone,
        'address': address,
        'city': city,
        'district': district,
        'subDistrict': subDistrict,
        'zipCode': zipCode,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
        'username': firstName.toLowerCase().replaceAll(' ', '') + '123',
        'bio': 'Pengguna baru',
        'gender': '-',
        'birthDate': '-',
      });

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign In
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
