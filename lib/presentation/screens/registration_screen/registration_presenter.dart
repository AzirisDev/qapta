import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_view_model.dart';
import 'package:ad_drive/presentation/screens/wrapper.dart';
import 'package:flutter/material.dart';

class RegistrationPresenter extends BasePresenter<RegistrationViewModel> {
  RegistrationPresenter(RegistrationViewModel model) : super(model);

  TextEditingController fullNameController = TextEditingController();

  late final String phoneNumber;
  late final String uid;

  final formKey = GlobalKey<FormState>();

  var cities = [
    "Almaty",
    "Nur-Sultan",
    "Shymkent",
  ];

  var selectedCity;

  @override
  void onInitWithContext() async {
    super.onInitWithContext();
  }

  void onChanged(String newValue) {
    selectedCity = newValue;
    updateView();
  }

  void addUserToDatabase() {
    model.entering = true;
    model.userModel = UserData(
      uid: uid,
      city: selectedCity,
      username: fullNameController.text,
      phoneNumber: phoneNumber,
    );
    userScope.userData = model.userModel;
    addUser();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const Wrapper(),
      ),
    );
  }

  void addUser() async {
    await SharedPreferencesRepository().addUserData(model.userModel);
    FireStoreInstance().addUser(model.userModel);
  }
}
