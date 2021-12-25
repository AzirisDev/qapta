import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_presenter.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_view_model.dart';
import 'package:flutter/material.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final ChangeProfilePresenter _presenter =
      ChangeProfilePresenter(ChangeProfileViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChangeProfileViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
            appBar: customAppBar(title: "Изменить"),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _presenter.nameController,
                    hint: "Имя",
                    label: "Имя",
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length < 8) {
                        return "Введите имя";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _presenter.emailController,
                    hint: "Email",
                    label: "email",
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length < 8) {
                        return "Введите email";
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: CustomButton(
                          title: "Изменить",
                          onClick: () {
                            _presenter.changeProfileName();
                          }))
                ],
              ),
            ),
            backgroundColor: AppColors.MONO_WHITE,
          );
        });
  }
}
