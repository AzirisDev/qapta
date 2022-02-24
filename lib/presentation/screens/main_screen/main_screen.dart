import 'dart:async';

import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/helper/bottom_nav_bar_provider.dart';
import 'package:ad_drive/manager/notification_manager.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/popup.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_screen_presenter.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final UserData user;

  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime alarmTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 55, 0);

  @override
  void initState() {
    super.initState();
    localNotificationManager;
    Timer(
      alarmTime.difference(DateTime.now()),
      () async {
        // if (UserScopeWidget.of(context).isRiding) {
          await localNotificationManager.showNotification();
        // }
      },
    );
  }

  final MainPresenter _presenter = MainPresenter(MainViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    _presenter.initUserData(widget.user);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return StreamBuilder<MainViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return Scaffold(
            extendBody: true,
            backgroundColor: provider.currentIndex == 1 && _presenter.isJobAvailable
                ? AppColors.PRIMARY_BLUE
                : null,
            body: Stack(
              alignment: Alignment.center,
              children: [
                _presenter.currentTab[provider.currentIndex],
                if (!_presenter.isConnected)
                  Material(
                    color: AppColors.MONO_BLACK.withOpacity(0.6),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.MONO_WHITE,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Проверьте подключение\nк интернету",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: Image.asset(
                                'assets/main_images/no_connection.gif',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              elevation: provider.currentIndex == 1 ? 0 : null,
              backgroundColor: AppColors.PRIMARY_BLUE,
              child: const Icon(Icons.map_rounded, color: AppColors.MONO_WHITE),
              onPressed: () {
                provider.currentIndex = 1;
                _presenter.getJobAvailable();
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        minWidth: 40,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () async {
                          if (_presenter.userScope.isRiding) {
                            Popups.showPopup(
                              title: "Завершите поездку, чтобы перейти на другие страницы",
                              context: context,
                              buttonText: "Ok",
                            );
                          } else {
                            provider.currentIndex = 0;
                          }
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 2,
                              top: 3,
                              child: Icon(
                                Icons.home_outlined,
                                color: provider.currentIndex == 0
                                    ? Colors.black12
                                    : Colors.transparent,
                                size: 35,
                              ),
                            ),
                            const Icon(
                              Icons.home_outlined,
                              color: AppColors.PRIMARY_BLUE,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        minWidth: 40,
                        onPressed: () async {
                          if (_presenter.userScope.isRiding) {
                            Popups.showPopup(
                              title: "Завершите поездку, чтобы перейти на другие страницы",
                              context: context,
                              buttonText: "Ok",
                            );
                          } else {
                            provider.currentIndex = 2;
                          }
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              right: 2,
                              top: 3,
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: provider.currentIndex == 2
                                    ? Colors.black12
                                    : Colors.transparent,
                                size: 35,
                              ),
                            ),
                            const Icon(
                              Icons.person_outline_rounded,
                              color: AppColors.PRIMARY_BLUE,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.userScope.dispose();
  }
}
