import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_presenter.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingPresenter _presenter = OnboardingPresenter(OnboardingViewModel(ScreenState.None));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.only(top: 100),
    );

    return IntroductionScreen(
      key: _presenter.introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Ad Drive - opportunity to make extra money while driving.",
          image: _presenter.buildImage('main_icon.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Be with us",
          body: "Choose company for cooperation. Choose your advertisement campaign.",
          image: _presenter.buildImage('main_icon.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Wrap your car",
          body: "Drive to nearest pasting point that will be shown on the map.",
          image: _presenter.buildImage('main_icon.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Make money",
          body: "Don't forget to turn on the app every time you drive",
          image: _presenter.buildImage('main_icon.svg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _presenter.onIntroEnd(context),
      onSkip: () => _presenter.onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding:
          kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
