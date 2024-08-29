import 'dart:ffi';

class StoreData {
  String? id;
  int? availableCups;
  String? phoneNumber;
  String? name;
  String? image;
  String? email;
  String? address;
  double? longitude;
  String? userType;
  String? password;
  double? latitude;
  bool? isVerified;
  bool? isActive;

  StoreData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.userType,
    required this.isVerified,
    required this.isActive,
    required this.availableCups,
    required this.phoneNumber,
    required this.name,
    required this.image,
    required this.email,
    required this.password,
  });

  // A factory method to convert a Map to UserData object
  factory StoreData.fromMap(Map<String, dynamic> map) {
    return StoreData(
      id: map['id'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      userType: map['userType'] ?? '',
      isVerified: map['isVerified'] ?? false,
      isActive: map['isActive'] ?? false,
      availableCups: map['availableCups'] ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // A method to convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'address': address,
      'userType': userType,
      'isVerified': isVerified,
      'availableCups': availableCups,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'password': password,
      'isActive': isActive,
    };
  }
}
