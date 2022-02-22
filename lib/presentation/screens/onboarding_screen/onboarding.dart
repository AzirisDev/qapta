import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/contants/theme.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_presenter.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_view_model.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/widgets/page_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnBoardingPresenter _presenter = OnBoardingPresenter(OnboardingViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.MONO_WHITE,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: CustomTheme.darkStatusBarIcons(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              SizedBox(
                height: 450,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _presenter.pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _presenter.currentPage = page;
                    });
                  },
                  children: const <Widget>[
                    PageOnBoarding(
                      asset: 'assets/main_images/onboarding1.gif',
                      text: 'Выбирайте из каталога понравившуюся компанию',
                    ),
                    PageOnBoarding(
                      asset: 'assets/main_images/onboarding2.gif',
                      text: 'Отправляйте заявку и ожидайте ободрения',
                    ),
                    PageOnBoarding(
                      asset: 'assets/main_images/onboarding3.gif',
                      text: 'После одобрения мы клеем рекламу на Вашем автомобиле',
                    ),
                    PageOnBoarding(
                      asset: 'assets/main_images/onboarding4.gif',
                      text:
                          'Фотографируйте автомобиль после каждой поездки и получайте деньги на счет!',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _presenter.buildPageIndicator(),
              ),
              const Spacer(flex: 1),
              _presenter.button(),
            ],
          ),
        ),
      ),
    );
  }
}
