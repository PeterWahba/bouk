class UserData {
  String? id;
  int? availableCups;
  String? phoneNumber;
  String? name;
  String? email;
  String? userType;
  String? password;
  bool? isVerified;

  UserData({
    required this.id,
    required this.userType,
    required this.isVerified,
    required this.availableCups,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.password,
  });

  // A factory method to convert a Map to UserData object
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      userType: map['userType'] ?? '',
      isVerified: map['isVerified'] ?? false,
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
      'userType': userType,
      'isVerified': isVerified,
      'availableCups': availableCups,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
