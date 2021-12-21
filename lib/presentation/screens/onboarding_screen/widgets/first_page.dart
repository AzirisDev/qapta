import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/screens/login_screen/login.dart';
import 'package:ad_drive/presentation/screens/onboarding_screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: '', color: Colors.transparent),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 1),
              SizedBox(
                width: 300,
                height: 300,
                child: SvgPicture.asset('assets/icons/blue_q.svg'),
              ),
              CustomButton(
                  title: "Продолжить",
                  onClick: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
                    );
                  }),
              CustomButton(
                title: "Пропустить",
                onClick: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                textColor: AppColors.PRIMARY_BLUE,
                backgroundColor: Colors.transparent,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
