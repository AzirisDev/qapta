import 'package:ad_drive/presentation/helpers/utils.dart';
import 'package:flutter/material.dart';

class GeneralScaffold extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  final Color backgroundColor;

  const GeneralScaffold({Key? key, required this.child, this.appBar, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Utils.hideKeyboard(context),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        body: child,
      ),
    );
  }
}
