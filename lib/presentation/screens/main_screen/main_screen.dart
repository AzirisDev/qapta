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
      extendBody: true,
      body: _presenter.currentTab[provider.currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        clipBehavior: Clip.hardEdge,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: AppColors.PRIMARY_BLUE),
            child: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.currentIndex = index;
              },
              selectedItemColor: AppColors.MONO_WHITE,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              selectedIconTheme: const IconThemeData(
                size: 30,
              ),
              unselectedItemColor: AppColors.MONO_WHITE.withOpacity(0.5),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_rounded),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.gps_fixed_rounded),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
