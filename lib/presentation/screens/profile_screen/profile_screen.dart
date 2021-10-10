import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_presenter.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfilePresenter _presenter = ProfilePresenter(ProfileViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
              appBar: AppBar(
                backgroundColor: AppColors.PRIMARY_BLUE,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      color: AppColors.PRIMARY_BLUE,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        //TODO: make avatar
                        const MainIcon(width: 100, color: AppColors.MONO_WHITE),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_BLUE,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            _presenter.model.userData.username,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      title: "Sign out",
                      onClick: _presenter.signOut,
                      backgroundColor: AppColors.PRIMARY_BLUE,
                      textColor: AppColors.MONO_WHITE,
                      borderColor: AppColors.PRIMARY_BLUE,
                      icon: Icons.exit_to_app_rounded,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white);
        });
  }
}
