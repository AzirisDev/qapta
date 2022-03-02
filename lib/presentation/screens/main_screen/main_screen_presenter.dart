import 'dart:async';

import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/helpers/get_job_available.dart';
import 'package:ad_drive/presentation/screens/companies_view_screen/companies_view.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_view_model.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_screen.dart';
import 'package:ad_drive/presentation/screens/profile_screen/profile_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MainPresenter extends BasePresenter<MainViewModel> {
  MainPresenter(MainViewModel model) : super(model);

  bool isJobAvailable = true;

  bool isConnected = true;

  late StreamSubscription connectionSubscription;

  var currentTab = [
    const CompaniesScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  bool getJobAvailable(){
    bool canWork = JobAvailability().getJobAvailable();
    if(canWork){
      isJobAvailable = true;
      updateView();
    } else {
      isJobAvailable = false;
      updateView();
    }
    return canWork;
  }

  @override
  void onInitWithContext() {
    super.onInitWithContext();
    connectionSubscription = userScope.connectionStream.listen((event) {
      if(event == ConnectivityResult.wifi || event == ConnectivityResult.mobile){
        isConnected = true;
      } else {
        isConnected = false;
      }
      updateView();
    });
    getJobAvailable();
  }

  void initUserData(UserData user) {
    userScope.userData = user;
    updateView();
  }

  @override
  void dispose() {
    super.dispose();
    connectionSubscription.cancel();
  }
}
