import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePresenter extends BasePresenter<ProfileViewModel> {
  ProfilePresenter(ProfileViewModel model) : super(model);

  @override
  void onInitWithContext() {
    if (UserScope.of(context).user != null) model.userData = UserScope.of(context).user!;
    super.onInitWithContext();
  }

  void signOut() async {
    await FirebaseDatabase().signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
