import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  bool isMobile() => Platform.isAndroid || Platform.isIOS;
  bool isDesktop() => Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
    SystemChannels.textInput.invokeListMethod('TextInput.show');
  }
}
