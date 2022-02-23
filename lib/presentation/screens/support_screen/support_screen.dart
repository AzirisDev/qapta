import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/support_screen/support_presenter.dart';
import 'package:ad_drive/presentation/screens/support_screen/support_view_model.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final SupportPresenter _presenter = SupportPresenter(SupportViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SupportViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
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
                      focusNode: _presenter.questionFocus,
                      minLines: 2,
                      controller: _presenter.questionController,
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
                    CustomButton(title: "Отправить", onClick: _presenter.sendFeedback),
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
        });
  }
}
