class UserData {
  String city;
  String username;
  String phoneNumber;

  UserData({required this.city, required this.username, required this.phoneNumber});

  UserData.fromJson(Map<String, Object?> json)
      : this(
          city: json['city'] as String,
          username: json['username'] as String,
          phoneNumber: json['phoneNumber'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}
