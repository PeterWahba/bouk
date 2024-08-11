class SocialModel {
  String? uri;

  SocialModel({
    required this.uri,
  });

  // Factory method to create an InfoModel from a Map
  factory SocialModel.fromMap(Map<String, dynamic> map) {
    return SocialModel(
      uri: map['uri'],
    );
  }

  // Method to convert InfoModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
    };
  }
}
