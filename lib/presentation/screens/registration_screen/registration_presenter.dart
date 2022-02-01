import 'dart:io';

import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/card.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/helpers/photo_uploader.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_screen.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPresenter extends BasePresenter<RegistrationViewModel> {
  RegistrationPresenter(RegistrationViewModel model) : super(model);

  TextEditingController fullNameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? _avatarUrlServer;

  late final String phoneNumber;
  late final String uid;

  final formKey = GlobalKey<FormState>();

  var cities = [
    "Almaty",
    "Nur-Sultan",
    "Shymkent",
  ];

  late String selectedCity;

  @override
  void onInitWithContext() async {
    super.onInitWithContext();
  }

  void onChanged(String newValue) {
    selectedCity = newValue;
    updateView();
  }

  void addPhoto() async {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        actions: [
          CustomButton(
              title: "Камера",
              onClick: () {
                Navigator.pop(context, ImageSource.camera);
              }),
          CustomButton(
              title: "Галерея",
              onClick: () {
                Navigator.pop(context, ImageSource.gallery);
              }),
        ],
      ),
    ).then((ImageSource? source) async {
      if (source != null) {
        final photo = await _picker.pickImage(source: source);
        model.avatarUrl = photo!.path;
        updateView();
        List<String> url =
            await PhotoUploader(userScopeData: userScope).uploadImageFile([File(photo.path)]);
        _avatarUrlServer = url.first;
      }
    });
    updateView();
  }

  void addUserToDatabase() {
    model.entering = true;
    model.userModel = UserData(
      uid: uid,
      city: selectedCity,
      username: fullNameController.text,
      phoneNumber: phoneNumber,
      avatarUrl: _avatarUrlServer ?? "",
      documents: [],
      cardModel: CardModel.empty(),
    );
    userScope.userData = model.userModel!;
    addUser();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => MainScreen(user: model.userModel!),
      ),
    );
  }

  void addUser() async {
    await SharedPreferencesRepository().addUserData(model.userModel!);
    FireStoreInstance().addUser(model.userModel!);
  }
}
