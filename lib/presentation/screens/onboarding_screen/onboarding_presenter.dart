import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPresenter extends BasePresenter<OnboardingViewModel> {
  OnBoardingPresenter(OnboardingViewModel model) : super(model);

  final int numPages = 4;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget button() {
    switch (currentPage) {
      case 0:
        return CustomButton(
            textColor: AppColors.PRIMARY_BLUE,
            backgroundColor: Colors.transparent,
            title: 'Дальше',
            onClick: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            });
      case 1:
        return CustomButton(
            textColor: AppColors.PRIMARY_BLUE,
            backgroundColor: Colors.transparent,
            title: 'Понятно',
            onClick: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            });
      case 2:
        return CustomButton(
            textColor: AppColors.PRIMARY_BLUE,
            backgroundColor: Colors.transparent,
            title: 'Продолжить',
            onClick: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            });
      case 3:
        return CustomButton(
            textColor: AppColors.PRIMARY_BLUE,
            backgroundColor: Colors.transparent,
            title: 'Начать',
            onClick: () {
              onIntroEnd(context);
            });
    }
    return CustomButton(
        textColor: AppColors.PRIMARY_BLUE,
        backgroundColor: Colors.transparent,
        title: 'Начать',
        onClick: () {
          onIntroEnd(context);
        });
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 10 : 7,
      width: isActive ? 10 : 7,
      decoration: BoxDecoration(
        color: isActive ? AppColors.PRIMARY_BLUE : AppColors.PRIMARY_BLUE.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

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
