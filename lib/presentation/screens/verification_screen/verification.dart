import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/verification_screen/verification_presenter.dart';
import 'package:ad_drive/presentation/screens/verification_screen/verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationScreen extends StatefulWidget {
  final String? verificationId;
  final UserData user;

  const VerificationScreen({Key? key, this.verificationId, required this.user}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationPresenter _presenter = VerificationPresenter(VerificationViewModel(ScreenState.None));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    _presenter.model.verificationId = widget.verificationId;
    _presenter.model.userModel = widget.user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "Verification",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Enter code from SMS",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              Form(
                key: _presenter.formKey,
                child: CustomTextField(
                  controller: _presenter.codeController,
                  hint: "code",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _presenter.codeFormatter,
                  ],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 8,
                ),
              ),
              CustomButton(
                title: "Verify",
                onClick: _presenter.startSignInWithPhoneAuthCredential,
                showLoading: _presenter.model.verifyCode,
              ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }
}
