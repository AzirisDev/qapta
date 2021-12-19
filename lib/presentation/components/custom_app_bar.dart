import 'package:flutter/material.dart';

import '../../app_colors.dart';

AppBar CustomAppBar({required String title, Color color = AppColors.PRIMARY_BLUE}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: AppColors.MONO_WHITE,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: color,
  );
}
