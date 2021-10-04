import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/model/user_model.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding.dart';
import 'package:ad_drive/presentation/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/bottom_nav_bar_provider.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 1);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(value: FirebaseDatabase().user, initialData: null),
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
      ],
      child: UserScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
          ),
          home: initScreen == null ? OnboardingScreen() : Wrapper(),
        ),
      ),
    );
  }
}
