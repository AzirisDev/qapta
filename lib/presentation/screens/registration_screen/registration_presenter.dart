import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_view_model.dart';
import 'package:ad_drive/presentation/screens/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPresenter extends BasePresenter<RegistrationViewModel> {
  RegistrationPresenter(RegistrationViewModel model) : super(model);

  TextEditingController fullNameController = TextEditingController();

  late final String phoneNumber;

  final FirebaseAuth auth = FirebaseDatabase().auth;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late CollectionReference users;

  final formKey = GlobalKey<FormState>();

  var cities = [
    "Almaty",
    "Nur-Sultan",
    "Shymkent",
  ];

  var selectedCity;

  @override
  void onInitWithContext() async {
    users = fireStore.collection("users").withConverter<UserData>(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson());
    super.onInitWithContext();
  }

  void onChanged(String newValue) {
    selectedCity = newValue;
    updateView();
  }

  void addUserToDatabase() {
    model.entering = true;
    model.userModel =
        UserData(city: selectedCity, username: fullNameController.text, phoneNumber: phoneNumber);
    UserScope.of(context).user = model.userModel;
    addUser();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => Wrapper(),
      ),
    );
  }

  void addUser() async {
    await users.add(model.userModel);
  }
}
