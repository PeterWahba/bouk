class UserData {
  String? id;
  int? availableCups;
  String? phone;
  String? name;
  String? email;
  String? password;

  UserData({
    required this.id,
    required this.availableCups,
    required this.phone,
    required this.name,
    required this.email,
    required this.password,
  });

  // A factory method to convert a Map to UserData object
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      availableCups: map['availableCups'] ?? 0,
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // A method to convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'availableCups': availableCups,
      'phone': phone,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
