class UserData {
  String uid;
  String city;
  String username;
  String phoneNumber;
  List<String> documents;

  UserData(
      {required this.uid,
      required this.city,
      required this.username,
      required this.phoneNumber,
      required this.documents});

  UserData.fromJson(Map<String, Object?> json)
      : this(
          uid: json["uid"] as String,
          city: json['city'] as String,
          username: json['username'] as String,
          phoneNumber: json['phoneNumber'] as String,
          documents: List<String>.from(json['documents'] as List<dynamic>),
        );

  toJson() {
    return {
      'uid': uid,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
      'documents': documents,
    };
  }
}
