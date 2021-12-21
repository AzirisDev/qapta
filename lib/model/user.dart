class UserData {
  String uid;
  String city;
  String username;
  String phoneNumber;
  String email;
  List<String> documents;

  UserData(
      {required this.uid,
      required this.city,
      required this.username,
      required this.phoneNumber,
      required this.email,
      required this.documents});

  UserData.fromJson(Map<String, Object?> json)
      : this(
          uid: json["uid"] as String,
          city: json['city'] as String,
          username: json['username'] as String,
          phoneNumber: json['phoneNumber'] as String,
          email: json['email'] as String,
          documents: List<String>.from(json['documents'] as List<dynamic>),
        );

  toJson() {
    return {
      'uid': uid,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'documents': documents,
    };
  }
}
