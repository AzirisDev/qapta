class UserData {
  String uid;
  String city;
  String username;
  String phoneNumber;

  UserData(
      {required this.uid, required this.city, required this.username, required this.phoneNumber});

  UserData.fromJson(Map<String, Object?> json)
      : this(
          uid: json["uid"] as String,
          city: json['city'] as String,
          username: json['username'] as String,
          phoneNumber: json['phoneNumber'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}
