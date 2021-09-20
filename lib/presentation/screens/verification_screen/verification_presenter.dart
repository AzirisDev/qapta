import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/verification_screen/verification_view_model.dart';
import 'package:ad_drive/presentation/screens/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationPresenter extends BasePresenter<VerificationViewModel> {
  VerificationPresenter(VerificationViewModel model) : super(model);

  TextEditingController codeController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final FirebaseAuth auth = FirebaseDatabase().auth;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late CollectionReference users;

  final formKey = GlobalKey<FormState>();

  final codeFormatter = CodeTextInputFormatter();

  @override
  void onInitWithContext() {
    users = fireStore.collection("users").withConverter<UserData>(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson());
    super.onInitWithContext();
  }

  void startSignInWithPhoneAuthCredential() {
    if (formKey.currentState!.validate()) {
      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
          verificationId: model.verificationId!, smsCode: codeController.text.replaceAll("-", ""));
      addUser();
      signWithPhoneAuthCredential(phoneCredential);
    }
  }

  void addUser() async {
    await users.add(model.userModel);
  }

  void signWithPhoneAuthCredential(PhoneAuthCredential phoneCredential) async {
    model.verifyCode = true;
    updateView();
    try {
      final authCredential = await auth.signInWithCredential(phoneCredential);
      if (authCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => Wrapper(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(e.message!)));
    }
    updateView();
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
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
