import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_presenter.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_view_model.dart';
import 'package:ad_drive/presentation/screens/profile_screen/widgets/setting_tile.dart';
import 'package:ad_drive/styles.dart';
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
                                            offset: const Offset(0, 0), // changes position of shadow
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 130,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            child: Image.network(
                                              'https://s3-alpha-sig.figma.com/img/fd16/f7c0/f7413b2e46fd5b05c964dd658938cd24?Expires=1640563200&Signature=WkfHgDlCgFMifiz3mGrrQsyFQL8tHyG8F3gcghZXu9dcYDYdRds8HaBe~DqazvC8vR8oh9WhsmZvdwUOJMZv7W4v2VBtwgoV6Q-G--ratu2O8cFAd4u7PULs8Nos9iNL8vzG6JhX~5JS15tcGc8iPBlzVBUjwVg3aNsV8oJjS~yL0iuzS3abU~Ef7qnf8fniQGNbWtheuIeRr9V-H6mPxitOegYgRiwgQ2coeaokU1x8mtvoZYXQvvHD-ZdSMVEs7A4bkEHFY5N69dZf-QvutV-hBeNDoQQIMR5kerPjyPuJOqJKmWuJFVLCLh2O2NPd7JmEOZSn8Nj8q~KfB7u9-Q__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                                              fit: BoxFit.fitHeight,
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
                          title: 'Карта',
                          onClick: _presenter.linkCard,
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
                        SettingTile(
                            title: 'Выйти', onClick: _presenter.signOut, isLogOut: true),
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
