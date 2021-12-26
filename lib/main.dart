import 'package:ad_drive/data/firebase.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/model/user_model.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_profile.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_screen.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/widgets/first_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/bottom_nav_bar_provider.dart';
import 'model/company.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 1);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserScopeWidget(
      child: Builder(builder: (context) {
        return MultiProvider(
          providers: [
            StreamProvider<UserModel?>.value(value: FirebaseDatabase().user, initialData: null),
            ChangeNotifierProvider<BottomNavigationBarProvider>(
              create: (_) => BottomNavigationBarProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder(
              future: UserScopeWidget.of(context).init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // if (snapshot.data == null) {
                //   return const Center(
                //     child: Text("data is null"),
                //   );
                // }
                // UserData user = snapshot.data;
                // final userLoggedIn = Provider.of<UserModel?>(context);
                // if (userLoggedIn == null || user.uid == "") {
                //   return initScreen == null ? const FirstPage() : const LoginScreen();
                // } else {
                //   return MainScreen(
                //     user: user,
                //   );
                // }
                return CompanyProfile(
                  company: Company(
                    name: "Apple Inc.",
                    description: lorem(words: 60, paragraphs: 2),
                    logo: "assets/icons/apple_logo.svg",
                    prices: {"1 month": 65, "3 month": 155, "6 month": 456},
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
