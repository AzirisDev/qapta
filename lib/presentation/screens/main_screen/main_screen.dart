import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/helper/bottom_nav_bar_provider.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_screen_presenter.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainPresenter _presenter = MainPresenter(MainViewModel(ScreenState.None));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: _presenter.currentTab[provider.currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          backgroundColor: AppColors.PRIMARY_BLUE,
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.currentIndex = index;
          },
          selectedItemColor: AppColors.MONO_WHITE,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedIconTheme: IconThemeData(
            size: 30,
          ),
          unselectedItemColor: AppColors.MONO_WHITE.withOpacity(0.5),
          items: [
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
            )
          ],
        ),
      ),
    );
  }
}
