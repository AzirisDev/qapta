import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/popup.dart';
import 'package:ad_drive/presentation/screens/support_screen/support_view_model.dart';
import 'package:flutter/material.dart';

class SupportPresenter extends BasePresenter<SupportViewModel> {
  SupportPresenter(SupportViewModel model) : super(model);

  TextEditingController questionController = TextEditingController();
  FocusNode questionFocus = FocusNode();

  void sendFeedback() async {
    startLoading();
    FocusManager.instance.primaryFocus?.unfocus();
    if (model.isLoading) {
      Popups.showPopup(
        title: "Отправляем ваш запрос",
        description: "Это займет несколько секунд",
        context: context,
        isLoading: true,
      );
    }
    await FireStoreInstance()
        .sendFeedback(uid: userScope.userData.uid, text: questionController.text);
    endLoading();
    questionController.text = '';
    questionFocus.unfocus();
    updateView();
    Navigator.pop(context);
    Popups.showPopup(
      title: "Спасибо!",
      description: "Ваша запрос отправлена!\nМы с вами скоро свяжемся!",
      buttonText: "Ok",
      context: context,
    );
  }
}
