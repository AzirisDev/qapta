import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_presenter.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfilePresenter _presenter = ProfilePresenter(ProfileViewModel(ScreenState.None));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    if (UserScope.of(context).user != null) _presenter.model.userData = UserScope.of(context).user!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //TODO: make avatar
                    MainIcon(width: 100, color: AppColors.PRIMARY_BLUE),
                    Text(
                      _presenter.model.userData.username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _presenter.model.userData.city,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _presenter.model.userData.phoneNumber,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomButton(title: "Sign out", onClick: _presenter.signOut),
                  ],
                ),
              ),
              backgroundColor: Colors.white);
        });
  }
}
