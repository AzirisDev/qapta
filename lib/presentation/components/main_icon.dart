import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';

class MainIcon extends StatelessWidget {
  final double width;
  const MainIcon({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/main_icon.svg",
      width: width,
      color: AppColors.PRIMARY_BLUE,
    );
  }
}
