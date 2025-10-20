class UserModel {
  final String firstName;
  final String pictureUrl;
  final int age;
  final String city;
  bool isLiked;

  UserModel({
    required this.firstName,
    required this.pictureUrl,
    required this.age,
    required this.city,
    this.isLiked = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final picture = json['picture'] as Map<String, dynamic>? ?? {};
    print('Mapping pictureUrl: ${picture['large']}'); // Debug print
    return UserModel(
      firstName: json['name']['first'] as String,
      pictureUrl: picture['large'] as String? ?? 'https://via.placeholder.com/150', // Fallback URL
      age: json['dob']['age'] as int,
      city: json['location']['city'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, pictureUrl: $pictureUrl, age: $age, city: $city, isLiked: $isLiked)';
  }
}