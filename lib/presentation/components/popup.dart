import 'package:ad_drive/app_colors.dart';
import 'package:flutter/material.dart';

enum PopupsResult {
  ok,
  cancel,
  second,
}

class Popups {
  static Future<PopupsResult?> showPopup({
    // required VoidCallback onButtonTap,
    required BuildContext context,
    String? description,
    String? title,
    String? buttonText,
    String? cancelButtonText,
    Color? buttonColor,
    Color? textColor,
    String? secondButtonText,
    bool isLoading = false,
  }) async =>
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 30),
                  if (title != null)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.PRIMARY_BLUE,
                            strokeWidth: 2,
                          )
                        : _buildButtonForPopups(
                            textForButton: buttonText ?? 'OKAY',
                            context: context,
                            textColor: buttonColor ?? AppColors.MONO_WHITE,
                            buttonColor: buttonColor ?? AppColors.PRIMARY_BLUE,
                            isColorFilled: true,
                            onPressed: () => pop(
                              context,
                              PopupsResult.ok,
                            ),
                          ),
                  ),
                  if (secondButtonText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _buildButtonForPopups(
                        textForButton: secondButtonText,
                        context: context,
                        buttonColor: buttonColor ?? AppColors.PRIMARY_BLUE,
                        isColorFilled: false,
                        onPressed: () => pop(context, PopupsResult.second),
                        textColor: buttonColor ?? AppColors.MONO_WHITE,
                      ),
                    ),
                  if (cancelButtonText != null)
                    _buildCancelButton(
                      context: context,
                      textForCancel: cancelButtonText,
                    )
                  else
                    const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      );

  static void pop(BuildContext context, PopupsResult result) => Navigator.of(context).pop(result);

  static Widget _buildButtonForPopups({
    required VoidCallback onPressed,
    required String? textForButton,
    required BuildContext context,
    required Color buttonColor,
    required Color textColor,
    required bool isColorFilled,
  }) =>
      SizedBox(
        width: double.infinity,
        child: MaterialButton(
          onPressed: onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3.0, color: buttonColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: textForButton == null
                ? null
                : Text(
                    textForButton,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: isColorFilled ? Colors.green : textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          color: isColorFilled ? buttonColor : Colors.transparent,
        ),
      );

  static Widget _buildCancelButton({
    required String textForCancel,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 38, top: 10),
        child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(AppColors.MONO_RED.withOpacity(0.2))),
          onPressed: () => pop(context, PopupsResult.cancel),
          child: Text(
            textForCancel,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.MONO_RED,
            ),
          ),
        ),
      );
}
