import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPresenter extends BasePresenter<OnboardingViewModel> {
  OnboardingPresenter(OnboardingViewModel model) : super(model);

  final introKey = GlobalKey<IntroductionScreenState>();

  Widget buildImage(String assetName, [double width = 200]) {
    return SvgPicture.asset(
      "assets/icons/$assetName",
      width: width,
      color: AppColors.PRIMARY_BLUE,
    );
  }

  void onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
