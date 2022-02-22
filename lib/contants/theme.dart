import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme extends InheritedWidget {

  const CustomTheme({Key? key, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static void setupMobileUi() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(CustomTheme.darkStatusBarIcons());
  }

  static SystemUiOverlayStyle darkStatusBarIcons() => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );

  static SystemUiOverlayStyle lightStatusBarIcons() => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
}