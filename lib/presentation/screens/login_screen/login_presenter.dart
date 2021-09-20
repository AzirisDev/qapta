import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_view_model.dart';
import 'package:ad_drive/presentation/screens/verification_screen/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPresenter extends BasePresenter<LoginViewModel> {
  LoginPresenter(LoginViewModel model) : super(model);

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final FirebaseAuth auth = FirebaseDatabase().auth;

  final formKey = GlobalKey<FormState>();

  final mobileFormatter = NumberTextInputFormatter();

  var cities = [
    "Almaty",
    "Nur-Sultan",
    "Shymkent",
  ];

  var selectedCity;

  Future verifyPhoneNumber() async {
    if (formKey.currentState!.validate()) {
      model.sendingCode = true;
      updateView();
      try {
        await auth.verifyPhoneNumber(
            phoneNumber: phoneNumberController.text,
            verificationCompleted: (phoneAuthCredential) async {},
            verificationFailed: (verificationFailed) async {
              scaffoldKey.currentState!
                  .showSnackBar(SnackBar(content: Text(verificationFailed.message!)));
            },
            codeSent: (verificationId, resendingToken) async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerificationScreen(
                            verificationId: verificationId,
                            user: UserData(
                                city: selectedCity,
                                username: fullNameController.text,
                                phoneNumber: phoneNumberController.text),
                          )));
            },
            codeAutoRetrievalTimeout: (verificationId) async {});
      } catch (e) {}
      updateView();
    }
  }

  void onChanged(String newValue) {
    selectedCity = newValue;
    updateView();
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex += 1;
    }
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 1) + ' ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(1, usedSubstringIndex = 4) + ' ');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 7) + ' ');
      if (newValue.selection.end >= 8) selectionIndex += 1;
    }
    if (newTextLength >= 10) {
      newText.write(newValue.text.substring(7, usedSubstringIndex = 9) + ' ');
      if (newValue.selection.end >= 10) selectionIndex += 1;
    }
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
