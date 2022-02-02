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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
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
                      child: _presenter.userScope.userData.avatarUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                _presenter.userScope.userData.avatarUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
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
                  ),
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
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: CustomButton(
                          title: "Изменить",
                          onClick: () {
                            _presenter.changeProfile();
                          }))
                ],
              ),
            ),
            backgroundColor: AppColors.MONO_WHITE,
          );
        });
  }
}
