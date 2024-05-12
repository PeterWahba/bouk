class UserData {
  String? id;
  String? phone;
  String? name;
  String? email;
  String? password;

  UserData({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.password,
  });

  // A factory method to convert a Map to UserData object
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
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
      'phone': phone,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
