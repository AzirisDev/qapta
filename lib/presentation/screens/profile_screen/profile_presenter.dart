import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePresenter extends BasePresenter<ProfileViewModel> {
  ProfilePresenter(ProfileViewModel model) : super(model);

  @override
  void onInitWithContext() async {
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      userScope.userData = userData;
    }
    model.userData = userScope.userData;
    updateView();
    super.onInitWithContext();
  }

  void signOut() async {
    await FirebaseDatabase().signOut();
    await SharedPreferencesRepository().clearUserData();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
