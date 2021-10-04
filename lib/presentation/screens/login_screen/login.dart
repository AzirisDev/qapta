import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPresenter _presenter = LoginPresenter(LoginViewModel(ScreenState.None));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
              key: _presenter.scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainIcon(
                                width: 100,
                                color: AppColors.PRIMARY_BLUE,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Verification",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Phone Number",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Form(
                            key: _presenter.formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _presenter.phoneNumberController,
                                  hint: "+7 ___ ___ __ __",
                                  validator: (text) {
                                    if (text == null || text.isEmpty || text.length < 16) {
                                      return "Enter your phone number";
                                    }
                                    return null;
                                  },
                                  formatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    _presenter.mobileFormatter,
                                  ],
                                  keyboardType: TextInputType.number,
                                  maxLength: 16,
                                ),
                                if (_presenter.isCodeSent)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text("Code",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ),
                                if (_presenter.isCodeSent)
                                  CustomTextField(
                                    controller: _presenter.codeController,
                                    hint: "code",
                                    validator: (text) {
                                      if (text == null || text.isEmpty || text.length < 8) {
                                        return "Enter your code";
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
                                  )
                              ],
                            ),
                          ),
                          CustomButton(
                            title: "Let's go",
                            onClick: _presenter.isCodeSent
                                ? _presenter.startSignInWithPhoneAuthCredential
                                : _presenter.verifyPhoneNumber,
                            showLoading: _presenter.model.sendingCode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white);
        });
  }
}
