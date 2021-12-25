import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/show_pop_up.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_view_model.dart';
import 'package:flutter/cupertino.dart';

class ChangeProfilePresenter extends BasePresenter<ChangeProfileViewModel> {
  ChangeProfilePresenter(ChangeProfileViewModel model) : super(model);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInitWithContext() async {
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      nameController.text = userData.username;
      emailController.text = userData.email;
    }
    updateView();
    super.onInitWithContext();
  }

  void changeProfileName() async {
    FireStoreInstance().updateUserData(userScope.userData.uid, nameController.text, emailController.text);
    UserData? userData = await FireStoreInstance().fetchUserData(userScope.userData.uid);
    if (userData != null) {
      userScope.userData = userData;
    }
    FocusScope.of(context).unfocus();
    showPopup(
      text: "Profile name changed",
      buttonText: "OK",
      onButtonTap: () {
        Navigator.pop(context);
      },
      buttonColor: AppColors.PRIMARY_BLUE,
      textColor: AppColors.MONO_BLACK,
      context: context,
    );
    updateView();
  }
}
