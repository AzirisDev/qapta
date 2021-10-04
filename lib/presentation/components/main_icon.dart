import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainIcon extends StatelessWidget {
  final double width;
  final Color color;
  const MainIcon({Key? key, required this.width, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/main_icon.svg",
      width: width,
      color: color,
    );
  }
}
