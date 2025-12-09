class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String district; // Kelurahan
  final String subDistrict; // Kecamatan
  final String zipCode;
  final String role;
  final String username;
  final String bio;
  final String gender;
  final String birthDate;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.zipCode,
    this.role = 'user',
    this.username = '',
    this.bio = '',
    this.gender = '',
    this.birthDate = '',
  });

  // Factory method untuk mengubah Map (dari Firestore) menjadi Object UserModel
  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      uid: id,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      subDistrict: json['subDistrict'] ?? '',
      zipCode: json['zipCode'] ?? '',
      role: json['role'] ?? 'user',
      username: json['username'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      birthDate: json['birthDate'] ?? '',
    );
  }

  // Method untuk mengubah Object UserModel menjadi Map (untuk dikirim ke Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'district': district,
      'subDistrict': subDistrict,
      'zipCode': zipCode,
      'role': role,
      'username': username,
      'bio': bio,
      'gender': gender,
      'birthDate': birthDate,
    };
  }
}
