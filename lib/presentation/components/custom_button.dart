import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/main_icon.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onClick;
  final showLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final bool? isSettings;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onClick,
    this.showLoading = false,
    this.backgroundColor = AppColors.PRIMARY_BLUE,
    this.textColor = AppColors.MONO_WHITE,
    this.borderColor = AppColors.PRIMARY_BLUE,
    this.icon,
    this.isSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor!,
          ),
        ),
        child: InkWell(
            onTap: onClick,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!showLoading)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: isSettings ?? false
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        if (isSettings != null ? !isSettings! : true)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: icon == null
                                ? MainIcon(
                                    width: 30,
                                    color: textColor!,
                                  )
                                : Icon(
                                    icon,
                                    color: textColor,
                                  ),
                          ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: textColor),
                        ),
                        isSettings ?? false
                            ? Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: textColor,
                              )
                            : Container()
                      ],
                    ),
                  ),
                if (showLoading)
                  Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: textColor,
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
