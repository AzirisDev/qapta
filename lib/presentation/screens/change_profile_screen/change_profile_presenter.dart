import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/popup.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_view_model.dart';
import 'package:flutter/material.dart';

class ChangeProfilePresenter extends BasePresenter<ChangeProfileViewModel> {
  ChangeProfilePresenter(ChangeProfileViewModel model) : super(model);

  TextEditingController nameController = TextEditingController();

  @override
  void onInitWithContext() async {
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      nameController.text = userData.username;
    }
    updateView();
    super.onInitWithContext();
  }

  void changeProfile() async {
    await FireStoreInstance().updateUserData(
        uid: userScope.userData.uid, newName: nameController.text);
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      userScope.userData = userData;
    }
    FocusScope.of(context).unfocus();
    Popups.showPopup(
      title: "Профиль изменен",
      buttonText: "Ok",
      textColor: AppColors.MONO_WHITE,
      context: context,
    );

    updateView();
  }
}
