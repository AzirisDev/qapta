import 'package:ad_drive/contants/theme.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../contants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginPresenter _presenter = LoginPresenter(LoginViewModel(ScreenState.none));

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
          return AnnotatedRegion(
            value: CustomTheme.darkStatusBarIcons(),
            child: GeneralScaffold(
              key: _presenter.scaffoldKey,
              backgroundColor: AppColors.MONO_GREY,
              child: SingleChildScrollView(
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
                        Container(
                          height: 350,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: AppColors.MONO_WHITE,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: SvgPicture.asset(
                                  'assets/icons/blue_q.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                width: 150,
                                padding: const EdgeInsets.all(14),
                                decoration: const BoxDecoration(
                                    color: AppColors.MONO_WHITE,
                                    border: Border(
                                        bottom: BorderSide(color: AppColors.PRIMARY_BLUE, width: 3))),
                                child: const Center(
                                  child: Text(
                                    "Вход",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Raleway',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Form(
                                  key: _presenter.formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        controller: _presenter.phoneNumberController,
                                        hint: "+7 ___ ___ __ __",
                                        label: "Номер телефона",
                                        validator: (text) {
                                          if (text == null || text.isEmpty || text.length < 16) {
                                            return "Введите номер телефона";
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
                                        CustomTextField(
                                          controller: _presenter.codeController,
                                          hint: "12-34-56",
                                          label: "Код",
                                          validator: (text) {
                                            if (text == null || text.isEmpty || text.length < 8) {
                                              return "Введите код";
                                            }
                                            return null;
                                          },
                                          formatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            _presenter.codeFormatter,
                                          ],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.start,
                                          maxLength: 8,
                                        )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 64),
                                  child: CustomButton(
                                    title: "Продолжить",
                                    onClick: _presenter.isCodeSent
                                        ? _presenter.startSignInWithPhoneAuthCredential
                                        : _presenter.verifyPhoneNumber,
                                    showLoading: _presenter.model.sendingCode,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
