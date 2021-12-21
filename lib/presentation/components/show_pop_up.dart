import 'package:flutter/material.dart';

import '../../../app_colors.dart';

Future<void> showPopup({
  required String text,
  String? title,
  required String buttonText,
  String? textForCancel,
  required VoidCallback onButtonTap,
  required Color buttonColor,
  required Color textColor,
  required BuildContext context,
  bool hideText = false,
  bool hideSecondButton = true,
  String? textForSecondButton,
  bool isLoading = false,
}) async {
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
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.MONO_BLACK,
                    ),
                  ),
                ),
              hideText
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        text,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: AppColors.MONO_BLACK,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: isLoading
                    ? Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: textColor,
                          ),
                        ),
                      )
                    : buildButtonForPopups(
                        textForButton: buttonText,
                        context: context,
                        textColor: buttonColor,
                        buttonColor: buttonColor,
                        isColorFilled: true,
                        onPressed: onButtonTap,
                      ),
              ),
              hideSecondButton
                  ? Container(color: Colors.green)
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: buildButtonForPopups(
                        textForButton: textForSecondButton,
                        context: context,
                        buttonColor: buttonColor,
                        isColorFilled: false,
                        onPressed: onButtonTap,
                        textColor: buttonColor,
                      ),
                    ),
              if (textForCancel != null)
                buildCancelButton(
                  context: context,
                  textForCancel: textForCancel,
                ),
              if (textForCancel == null)
                const SizedBox(
                  height: 10,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

buildButtonForPopups({
  required VoidCallback onPressed,
  required String? textForButton,
  required BuildContext context,
  required Color buttonColor,
  required Color textColor,
  required bool isColorFilled,
}) {
  return SizedBox(
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
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  letterSpacing: 0.5,
                  color: isColorFilled ? AppColors.MONO_WHITE : textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      color: isColorFilled ? buttonColor : Colors.transparent,
    ),
  );
}

buildCancelButton({
  required String textForCancel,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 38),
    child: TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        textForCancel,
        style: const TextStyle(
          fontFamily: 'Raleway',
          fontSize: 17,
          color: AppColors.MONO_BLACK,
        ),
      ),
    ),
  );
}
