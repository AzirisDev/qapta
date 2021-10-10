import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/settings_screen/settings_presenter.dart';
import 'package:ad_drive/presentation/screens/settings_screen/settings_view_model.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsPresenter _presenter = SettingsPresenter(SettingsViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: AppColors.PRIMARY_BLUE, borderRadius: BorderRadius.circular(12)),
                child: const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: AppColors.MONO_WHITE,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              backgroundColor: AppColors.MONO_WHITE,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  CustomButton(
                    title: "Change information",
                    onClick: _presenter.changeInfo,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                  const Text(
                    "Bank card",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  CustomButton(
                    title: "Link card",
                    onClick: _presenter.linkCard,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                  const Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  CustomButton(
                    title: "Support",
                    onClick: _presenter.support,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                  CustomButton(
                    title: "FAQ",
                    onClick: _presenter.faq,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                  CustomButton(
                    title: "Agreement",
                    onClick: _presenter.agreement,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                  CustomButton(
                    title: "Privacy policy",
                    onClick: _presenter.privacyPolicy,
                    backgroundColor: AppColors.MONO_WHITE,
                    borderColor: AppColors.PRIMARY_BLUE,
                    textColor: AppColors.PRIMARY_BLUE,
                    isSettings: true,
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.MONO_WHITE,
          );
        });
  }
}
