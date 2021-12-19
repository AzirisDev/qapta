import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: CustomAppBar(title: "FAQ"),
        child: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return QuestionCard(
                    question: list[index].first,
                    answer: list[index].last,
                  );
                }),
          ),
        ),
        backgroundColor: AppColors.MONO_WHITE);
  }

  List<List<String>> list = [
    [
      "Где скачать "
          "ваше приложение ?",
      "Приложение находится в разработке. После успешных тестов, его можно будет установить в AppStore и Google Play Market."
    ],
    [
      "Куда писать по "
          "поводу сотрудничества?",
      "support@qapta.kz"
    ],
    ["Как долго происходит верификация?", "В среднем верификация займет от 1 до 3 рабочих дней."],
    [
      "Как будут происходить выплаты?",
      "Выплаты будут происходить переводом на ваш банковский счет"
    ],
    [
      "От чего будет "
          "зависеть мой заработок?",
      "Ваш заработок будет зависеть от проезженного расстония, тарифов рекламной кампании и района где вы будете передвигаться."
    ],
  ];
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  final String question;
  final String answer;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.question,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                isTapped
                    ? const Icon(
                        Icons.keyboard_arrow_up_rounded,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      )
              ],
            ),
            if (isTapped)
              Padding(
                padding: EdgeInsets.only(left: 30, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.answer,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(
              indent: 30,
            )
          ],
        ),
      ),
    );
  }
}
