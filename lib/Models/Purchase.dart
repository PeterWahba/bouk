class PurchaseModel {
  int? availableCups;
  String? purchaseDate;
  String? coffeeName;
  double? price;

  PurchaseModel({
    required this.availableCups,
    required this.price,
    required this.purchaseDate,
    required this.coffeeName,
  });

  // A factory method to convert a Map to UserData object
  factory PurchaseModel.fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      availableCups: map['availableCups'] ?? '',
      price: map['price'] ?? 0,
      purchaseDate: map['purchaseDate'] ?? '',
      coffeeName: map['coffeeName'] ?? '',
    );
  }

  // A method to convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'availableCups': availableCups,
      'price': price,
      'purchaseDate': purchaseDate,
      'coffeeName': coffeeName,
    };
  }
}
