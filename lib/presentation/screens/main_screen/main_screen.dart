import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/helper/bottom_nav_bar_provider.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
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
    return Scaffold(
      body: _presenter.currentTab[provider.currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.PRIMARY_BLUE,
        child: const Icon(Icons.map_rounded, color: AppColors.MONO_WHITE),
        onPressed: () {
          provider.currentIndex = 1;
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
                  onPressed: () {
                    provider.currentIndex = 0;
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 2,
                        top: 3,
                        child: Icon(
                          Icons.home_outlined,
                          color: provider.currentIndex == 0 ? Colors.black12 : Colors.transparent,
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
              Expanded(flex: 1,child: Container()),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: 40,
                  onPressed: () {
                    provider.currentIndex = 2;
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 2,
                        top: 3,
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: provider.currentIndex == 2 ? Colors.black12 : Colors.transparent,
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
  }
}
