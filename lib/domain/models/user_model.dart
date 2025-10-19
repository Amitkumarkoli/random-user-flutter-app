class UserModel {
  final String firstName;
  final String pictureUrl;
  final int age;
  final String city;
  bool isLiked; // Tracks if the user is liked

  UserModel({
    required this.firstName,
    required this.pictureUrl,
    required this.age,
    required this.city,
    this.isLiked = false, // Default to not liked
  });

  // Factory to create UserModel from API JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['name']['first'] as String,
      pictureUrl: json['picture']['large'] as String,
      age: json['dob']['age'] as int,
      city: json['location']['city'] as String,
    );
  }
}