import 'package:ad_drive/model/card.dart';

class UserData {
  String uid;
  String city;
  String username;
  String phoneNumber;
  String avatarUrl;
  List<String> documents;
  CardModel cardModel;

  UserData({
    required this.uid,
    required this.city,
    required this.username,
    required this.phoneNumber,
    required this.documents,
    required this.avatarUrl,
    required this.cardModel,
  });

  UserData.fromJson(Map<String, Object?> json)
      : this(
          uid: json["uid"] as String,
          city: json['city'] as String,
          username: json['username'] as String,
          phoneNumber: json['phoneNumber'] as String,
          avatarUrl: json['avatarUrl'] as String,
          documents: List<String>.from(json['documents'] as List<dynamic>),
          cardModel: CardModel.fromJson(json['card_model'] as Map<String, dynamic>),
        );

  toJson() {
    return {
      'uid': uid,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'documents': documents,
      'cardModel': cardModel,
    };
  }
}
