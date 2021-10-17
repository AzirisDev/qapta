import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_view_model.dart';
import 'package:flutter/cupertino.dart';

class ChangeProfilePresenter extends BasePresenter<ChangeProfileViewModel> {
  ChangeProfilePresenter(ChangeProfileViewModel model) : super(model);

  TextEditingController nameController = TextEditingController();

  @override
  void onInitWithContext() {
    super.onInitWithContext();
  }

  void changeProfileName() async {
    FireStoreInstance().updateUserData(userScope.userData.uid, nameController.text);
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      userScope.userData = userData;
    }
    updateView();
  }
}
