class BannerModel {
  String? image;

  BannerModel({
    required this.image,
  });

  // A factory method to convert a Map to UserData object
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      image: map['image'] ?? '',
    );
  }

  // A method to convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }
}


