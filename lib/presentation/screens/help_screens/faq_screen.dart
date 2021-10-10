import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: CustomAppBar("FAQ"),
        child: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
    ["question1", "answer1"],
    ["question2", "answer2"],
    ["question3", "answer3"],
    ["question4", "answer4"],
    ["question5", "answer5"],
    ["question6", "answer6"],
    ["question7", "answer7"],
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
                Text(
                  widget.question,
                  style: const TextStyle(fontSize: 18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.answer,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
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
