import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/companies_view_screen/companies_view.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_view_model.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_screen.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_screen.dart';
import 'package:ad_drive/presentation/screens/settings_screen/settings_screen.dart';

class MainPresenter extends BasePresenter<MainViewModel> {
  MainPresenter(MainViewModel model) : super(model);

  var currentTab = [
    const CompaniesScreen(),
    const MapScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  void onInitWithContext() {
    super.onInitWithContext();
  }

  void initUserData(UserData user) {
    userScope.userData = user;
    updateView();
  }
}
