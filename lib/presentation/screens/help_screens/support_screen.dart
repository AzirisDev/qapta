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
        "mailto: qaptakz@gmail.com?subject=Feedback&body=${Uri.encodeFull(questionController.text)}";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: CustomAppBar("Support"),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ask question",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.MONO_BLACK.withOpacity(0.5)),
              ),
              CustomTextField(
                minLines: 2,
                controller: questionController,
                hint: "Ask a question. We will respond very soon.",
                validator: (text) {
                  if (text == null || text.isEmpty || text.length < 8) {
                    return "Enter your question";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(title: "Send", onClick: launchEmail),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Contact details",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.MONO_BLACK.withOpacity(0.5)),
              ),
              const Text(
                "qapta.kz@gmail.com",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w300, color: AppColors.PRIMARY_BLUE),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.MONO_WHITE);
  }
}
