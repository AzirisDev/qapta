import 'package:flutter/material.dart';

import '../../app_colors.dart';

AppBar CustomAppBar(String title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.MONO_WHITE,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: AppColors.PRIMARY_BLUE,
  );
}
