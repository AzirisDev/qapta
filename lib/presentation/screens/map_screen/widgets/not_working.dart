import 'package:flutter/material.dart';

import '../../../../app_colors.dart';

class NotWorkingWidget extends StatelessWidget {
  const NotWorkingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Image.asset(
                'assets/main_images/sleep.gif',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Qapta в это время не работает. \n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                color: AppColors.PRIMARY_BLUE,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Режим работы: \n09:00 - 20:00",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.PRIMARY_BLUE,
              ),
            ),
          )
        ],
      ),
    );
  }
}
