import 'package:ad_drive/styles.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';

AppBar customAppBar({required String title, Color color = Colors.transparent}) {
  return AppBar(
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
