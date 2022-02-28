import 'package:ad_drive/model/card.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreInstance {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static final FireStoreInstance _singleton = FireStoreInstance._internal();

  factory FireStoreInstance() {
    return _singleton;
  }

  FireStoreInstance._internal();

  void addUser(UserData user) async {
    await users.doc(user.uid).set(user);
  }

  Future<UserData?> fetchUserData({required String uid}) async {
    QuerySnapshot data = await users.where("uid", isEqualTo: uid).get();
    if (data.size != 0) {
      return data.docs.first.data() as UserData;
    } else {
      return null;
    }
  }

  Future<void> updateUserData(
      {required String uid,
      String? newName,
      CardModel? cardModel,
      List<String>? documents,
      String? avatarUrl}) async {
    await users.doc(uid).update({
      if (newName != null) "username": newName,
      if (documents != null) "documents": documents,
      if (cardModel != null) "cardModel": cardModel.toJson(),
      if (avatarUrl != null) "avatarUrl": avatarUrl
    });
  }

  Future<void> sendRequest(
      {required String uid, required String company, required String price}) async {
    await requests.doc(uid).set({
      "id": uid,
      "company": company,
      "price": price,
    });
  }

  Future<List<Company>> fetchCompanies() async {
    QuerySnapshot snapshot = await companies.get();
    List<Company> documents = [];
    for (var element in snapshot.docs) {
      documents.add(
        Company(
          name: element["name"],
          description: element["description"],
          logo: element["logo"],
          prices: element["prices"],
        ),
      );
    }
    return documents;
  }

  Future<void> sendStartRide(
      {required String uid, required String photoUrl, required String dateTimeStamp}) async {
    await rides.doc(uid + " " + dateTimeStamp).set({
      "uid": uid,
      "startPhoto": photoUrl,
      "startTime": Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> sendFinishRide(
      {required String uid,
      required String dateTimeStamp,
      required String photoUrl,
      required int distance,
      required List<double> longitude,
      required List<double> latitude}) async {
    await rides.doc(uid + " " + dateTimeStamp).update({
      "endPhoto": photoUrl,
      "endTime": Timestamp.fromDate(DateTime.now()),
      "distance": distance,
      "longitude": longitude,
      "latitude": latitude,
    });
  }

  Future<void> sendFeedback({required String uid, required String text}) async {
    await feedback.doc(uid).set({
      "uid": uid,
      "question": text,
      "date": Timestamp.fromDate(DateTime.now()),
    });
  }

  late CollectionReference users = fireStore.collection("users").withConverter<UserData>(
      fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
      toFirestore: (userModel, _) => userModel.toJson());

  late CollectionReference companies = fireStore.collection("companies").withConverter<Company>(
      fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
      toFirestore: (company, _) => company.toJson());

  late CollectionReference requests = fireStore.collection("requests");

  late CollectionReference rides = fireStore.collection("rides");

  late CollectionReference feedback = fireStore.collection("feedback");
}
