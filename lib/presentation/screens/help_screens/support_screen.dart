import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  TextEditingController questionController = TextEditingController();

  void launchEmail() async {
    final url =
        "mailto: support@qapta.kz?subject=Feedback&body=${Uri.encodeFull(questionController.text)}";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: customAppBar(title: "Поддержка"),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Опишите проблему",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.MONO_BLACK.withOpacity(0.5)),
              ),
              CustomTextField(
                minLines: 2,
                controller: questionController,
                hint: "Задайте вопрос. Мы вам ответим в скором времени",
                label: "Вопрос",
                validator: (text) {
                  if (text == null || text.isEmpty || text.length < 8) {
                    return "Задайте вопрос";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(title: "Отправить", onClick: launchEmail),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Контакты",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.MONO_BLACK.withOpacity(0.5)),
              ),
              const Text(
                "support@qapta.kz",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: AppColors.PRIMARY_BLUE,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.MONO_WHITE);
  }
}
