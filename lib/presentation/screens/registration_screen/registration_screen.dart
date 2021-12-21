import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
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
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                                    labelStyle:
                                        const TextStyle(color: Colors.black, fontSize: 17.0),
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
                            child: CustomTextField(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CustomButton(
                              title: "Continue",
                              onClick: _presenter.addUserToDatabase,
                              showLoading: _presenter.model.entering,
                            ),
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
