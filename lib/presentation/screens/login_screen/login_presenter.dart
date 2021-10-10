import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_view_model.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPresenter extends BasePresenter<LoginViewModel> {
  LoginPresenter(LoginViewModel model) : super(model);

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final codeFormatter = CodeTextInputFormatter();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final FirebaseAuth auth = FirebaseDatabase().auth;

  final formKey = GlobalKey<FormState>();

  final mobileFormatter = NumberTextInputFormatter();

  late final String verificationCode;

  bool isCodeSent = false;

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
              isCodeSent = true;
              model.sendingCode = false;
              verificationCode = verificationId;
              updateView();
            },
            codeAutoRetrievalTimeout: (verificationId) async {});
      } catch (e) {
        print(e);
      }
      updateView();
    }
  }

  void startSignInWithPhoneAuthCredential() {
    model.sendingCode = true;
    if (formKey.currentState!.validate()) {
      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: codeController.text.replaceAll("-", ""));
      signWithPhoneAuthCredential(phoneCredential);
    }
  }

  void signWithPhoneAuthCredential(PhoneAuthCredential phoneCredential) async {
    updateView();
    try {
      final authCredential = await auth.signInWithCredential(phoneCredential);
      if (authCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => RegistrationScreen(
              phoneNumber: phoneNumberController.text.replaceAll(" ", ""),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(e.message!)));
    }
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
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class CodeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 2) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + '-');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + '-');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
