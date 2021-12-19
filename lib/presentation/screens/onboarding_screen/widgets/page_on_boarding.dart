import 'package:ad_drive/presentation/screens/onboarding_screen/utilities/styles.dart';
import 'package:flutter/material.dart';

class PageOnBoarding extends StatelessWidget {
  final String text;
  final String asset;

  const PageOnBoarding({
    Key? key,
    required this.text,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(asset),
          const SizedBox(height: 40.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kTextStyle,
          ),
        ],
      ),
    );
  }
}