import 'package:ad_drive/model/user.dart';
import 'package:flutter/material.dart';

class UserScope extends StatefulWidget {
  final Widget child;

  const UserScope({required this.child});

  @override
  State<StatefulWidget> createState() => UserScopeState();

  static UserScopeState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedUserScope>()!.state;
  }
}

class UserScopeState extends State<UserScope> {
  UserData? _user;

  set user(UserData? user) {
    setState(() {
      _user = user;
    });
  }

  UserData? get user => _user != null ? _user! : null;

  @override
  Widget build(BuildContext context) {
    return InheritedUserScope(state: this, user: _user, child: widget.child);
  }
}

class InheritedUserScope extends InheritedWidget {
  const InheritedUserScope({
    required this.state,
    required this.user,
    required Widget child,
  }) : super(child: child);

  final UserScopeState state;
  final UserData? user;

  @override
  bool updateShouldNotify(InheritedUserScope old) => user != old.user;
}
