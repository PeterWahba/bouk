class BasketModel {
  int? productId;
  String? productName;
  int? quantity;

  BasketModel({
    this.productId,
    this.productName,
    this.quantity,
  });

  BasketModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    return data;
  }
}
