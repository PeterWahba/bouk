class QRArgumentsModel {
  String? availableCups;
  String? orderCups;
   String? id;
   QRArgumentsModel({required this.availableCups,required this.orderCups, required this.id });


   QRArgumentsModel.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     availableCups = json['availableCups'];
     orderCups = json['orderCups'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['availableCups'] = this.availableCups;
    data['orderCups'] = this.orderCups;
    return data;
  }

}