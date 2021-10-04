import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onClick;
  final showLoading;

  const CustomButton(
      {Key? key, required this.title, required this.onClick, this.showLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_BLUE,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
            onTap: onClick,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!showLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MainIcon(
                          width: 30,
                          color: AppColors.MONO_WHITE,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: AppColors.MONO_WHITE),
                      ),
                    ],
                  ),
                if (showLoading)
                  Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.MONO_WHITE,
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
