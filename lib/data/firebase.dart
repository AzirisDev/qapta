import 'package:ad_drive/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebase);
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {}
  }
}
