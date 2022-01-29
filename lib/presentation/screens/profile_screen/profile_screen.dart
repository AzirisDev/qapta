import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_presenter.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:ad_drive/presentation/screens/profile_screen/widgets/setting_tile.dart';
import 'package:ad_drive/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Аккаунт",
              style: appBarTextStyle,
            ),
          ),
          body: _presenter.model.userData != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _presenter.editProfile,
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                    width: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 20,
                                            offset:
                                                const Offset(0, 0), // changes position of shadow
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        if (_presenter.userScope.userData.avatarUrl.isNotEmpty)
                                          Container(
                                            width: 100,
                                            height: 130,
                                            decoration: const BoxDecoration(
                                                color: AppColors.PRIMARY_BLUE,
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(20))),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(20)),
                                              child: SvgPicture.network(
                                                'https://upload.wikimedia.org/wikipedia/commons/7/7e/Circle-icons-profile.svg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _presenter.userScope.userData.username,
                                                  style: const TextStyle(
                                                      color: AppColors.PRIMARY_BLUE,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Raleway'),
                                                ),
                                                Text(
                                                  _presenter.userScope.userData.username,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Raleway'),
                                                ),
                                                const Divider(
                                                  height: 10,
                                                  color: AppColors.MONO_BLACK,
                                                ),
                                                Text(
                                                  _presenter.userScope.userData.phoneNumber,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Raleway'),
                                                ),
                                                const Divider(
                                                  height: 10,
                                                  color: AppColors.MONO_BLACK,
                                                ),
                                                const Text(
                                                  "Сейчас продвигает: \nApple.kz",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Raleway'),
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SettingTile(
                          title: 'Договор с Qapta',
                          onClick: _presenter.agreement,
                        ),
                        SettingTile(
                          title: 'Поддержка',
                          onClick: _presenter.support,
                        ),
                        SettingTile(
                          title: 'Политика конфиденциальности',
                          onClick: _presenter.privacyPolicy,
                        ),
                        SettingTile(title: 'Выйти', onClick: _presenter.signOut, isLogOut: true),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.PRIMARY_BLUE,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
