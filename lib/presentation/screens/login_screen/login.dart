import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    _presenter.selectedCity = _presenter.cities[0];
    super.initState();
  }

  String? validateText(String text) {
    if (text.isEmpty) {
      return "Enter your name";
    }
    return null;
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
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Fill out the fields",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  isEmpty: _presenter.selectedCity == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _presenter.selectedCity,
                                      isDense: true,
                                      onChanged: (value) {
                                        if (value != null) _presenter.onChanged(value);
                                      },
                                      items: _presenter.cities.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Form(
                            key: _presenter.formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _presenter.fullNameController,
                                  hint: "full name",
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: _presenter.phoneNumberController,
                                  hint: "phone number",
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
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
                              ],
                            ),
                          ),
                          CustomButton(
                            title: "Send code",
                            onClick: _presenter.verifyPhoneNumber,
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
