import 'package:ad_drive/model/user_model.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return user != null
        ? MainScreen(
            user: UserScopeWidget.of(context).userData,
          )
        : const LoginScreen();
  }
}
