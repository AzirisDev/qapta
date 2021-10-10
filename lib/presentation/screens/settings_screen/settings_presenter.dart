import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/change_profile_screen/change_profile_screen.dart';
import 'package:ad_drive/presentation/screens/help_screens/agreement_screen.dart';
import 'package:ad_drive/presentation/screens/help_screens/faq_screen.dart';
import 'package:ad_drive/presentation/screens/help_screens/support_screen.dart';
import 'package:ad_drive/presentation/screens/link_card_screen/link_card_screen.dart';
import 'package:ad_drive/presentation/screens/settings_screen/settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPresenter extends BasePresenter<SettingsViewModel> {
  SettingsPresenter(SettingsViewModel model) : super(model);

  void changeInfo() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ChangeProfileScreen()));
  }

  void linkCard() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const LinkCardScreen()));
  }

  void support() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => SupportScreen()));
  }

  void faq() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => FAQScreen()));
  }

  void agreement() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const AgreementScreen()));
  }

  void privacyPolicy() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
