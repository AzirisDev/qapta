import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/user.dart';
import 'package:flutter/material.dart';

class UserScopeData {
  UserScopeWidgetState state;

  late UserData userData;
  bool isRiding = false;

  UserScopeData({required this.state});

  Future<UserData> init() async {
    UserData userData = await SharedPreferencesRepository().init();
    return userData;
  }

  void dispose() {}

  Future deAuth() async {
    await SharedPreferencesRepository().clearUserData();
    rebuild();
  }

  void rebuild() {
    state.rebuild();
  }
}

class _UserScopeWidget extends InheritedWidget {
  final UserScopeWidgetState state;
  final UserScopeData data;

  _UserScopeWidget._(Widget child, this.state, this.data) : super(child: child) {
    state.isColdStart = false;
  }

  factory _UserScopeWidget({required Widget child, required UserScopeWidgetState state}) {
    return _UserScopeWidget._(child, state, UserScopeData(state: state));
  }

  @override
  bool updateShouldNotify(InheritedWidget old) => true;
}

class UserScopeWidget extends StatefulWidget {
  final Widget child;

  const UserScopeWidget({Key? key, required this.child}) : super(key: key);

  static UserScopeData of(BuildContext context) {
    final widget = (context.dependOnInheritedWidgetOfExactType<_UserScopeWidget>())?.data;
    if (widget == null) {
      throw Exception('data was call on null');
    } else {
      return widget;
    }
  }

  @override
  State<StatefulWidget> createState() => UserScopeWidgetState();
}

class UserScopeWidgetState extends State<UserScopeWidget> {
  bool isColdStart = true;

  @override
  Widget build(BuildContext context) {
    return _UserScopeWidget(
      child: widget.child,
      state: this,
    );
  }

  void rebuild() {
    setState(() {});
  }
}
