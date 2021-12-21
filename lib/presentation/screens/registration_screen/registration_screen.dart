import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_presenter.dart';
import 'package:ad_drive/presentation/screens/registration_screen/registration_view_model.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  final String uid;

  const RegistrationScreen({Key? key, required this.phoneNumber, required this.uid})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final RegistrationPresenter _presenter =
      RegistrationPresenter(RegistrationViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.phoneNumber = widget.phoneNumber;
    _presenter.uid = widget.uid;
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _presenter.selectedCity = _presenter.cities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RegistrationViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: AppColors.MONO_WHITE.withOpacity(0.5),
                automaticallyImplyLeading: false,
                title: const Text(
                  "Регистрация",
                  style: TextStyle(
                    color: AppColors.PRIMARY_BLUE,
                    fontSize: 26,
                    fontFamily: 'RaleWay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 230,
                            width: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.MONO_WHITE,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: AppColors.PRIMARY_BLUE,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Загрузить фото",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Raleway',
                                      color: AppColors.MONO_BLACK.withOpacity(0.5)),
                                )
                              ],
                            ),
                          ),
                          Form(
                            key: _presenter.formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _presenter.fullNameController,
                                  hint: "full name",
                                  label: "Full name",
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: _presenter.emailNameController,
                                  hint: "email",
                                  label: "Email",
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Enter your email";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(fontFamily: 'Raleway',color: Colors.black, fontSize: 17.0),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      )),
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
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CustomButton(
                                    title: "Регистрация",
                                    onClick: _presenter.addUserToDatabase,
                                    showLoading: _presenter.model.entering,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: AppColors.MONO_GREY);
        });
  }
}
