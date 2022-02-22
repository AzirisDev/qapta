import 'package:ad_drive/contants/styles.dart';
import 'package:ad_drive/contants/theme.dart';
import 'package:flutter/material.dart';

import '../../contants/app_colors.dart';

AppBar customAppBar({required String title, Color color = Colors.transparent}) {
  return AppBar(
    systemOverlayStyle: CustomTheme.darkStatusBarIcons(),
    foregroundColor: AppColors.PRIMARY_BLUE,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: appBarTextStyle,
    ),
    backgroundColor: color,
  );
}
