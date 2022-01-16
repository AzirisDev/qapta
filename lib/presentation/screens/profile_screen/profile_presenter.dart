import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_screen.dart';
import 'package:ad_drive/presentation/screens/help_screens/agreement_screen.dart';
import 'package:ad_drive/presentation/screens/help_screens/support_screen.dart';
import 'package:ad_drive/presentation/screens/link_card_screen/link_card_screen.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void changeInfo() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ChangeProfileScreen()));
  }

  void linkCard() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const LinkCardScreen()));
  }

  void support() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const SupportScreen()));
  }

  void agreement() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const AgreementScreen()));
  }

  void editProfile() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ChangeProfileScreen()));
  }

  void privacyPolicy() async {
    const url = 'https://www.qapta.kz/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
