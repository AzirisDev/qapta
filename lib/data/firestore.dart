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

  Future<UserData?> fetchUserData(String uid) async {
    QuerySnapshot data = await users.where("uid", isEqualTo: uid).get();
    if (data.size != 0) {
      return data.docs.first.data() as UserData;
    } else {
      return null;
    }
  }

  void uploadDocumentsURL(String uid, List<String> documents) {
    users.doc(uid).update({"documents": documents});
  }

  void updateUserData(String uid, String newName, String newEmail) {
    users.doc(uid).update({"username": newName, "email": newEmail});
  }

  Future<List<Company>> fetchCompanies() async {
    var snapshot = await companies.get();
    List<Company> documents = [];
    int length = snapshot.docs.length;
    for (var element in snapshot.docs) {
      documents.add(
        Company(
          name: element['name'],
          description: element['description'],
          logo: element['logo'],
          prices: element['prices'
              ''],
        ),
      );
    }
    return documents;
  }

  late CollectionReference users = fireStore.collection("users").withConverter<UserData>(
      fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
      toFirestore: (userModel, _) => userModel.toJson());

  late CollectionReference companies = fireStore.collection("companies").withConverter<Company>(
      fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
      toFirestore: (company, _) => company.toJson());
}
