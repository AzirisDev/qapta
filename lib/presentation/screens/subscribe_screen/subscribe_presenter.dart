import 'dart:io';

import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/data/shared_preferences.dart';
import 'package:ad_drive/model/card.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/popup.dart';
import 'package:ad_drive/presentation/helpers/photo_uploader.dart';
import 'package:ad_drive/presentation/screens/link_card_screen/link_card_screen.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_view_model.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/widgets/contract_screen.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscribePresenter extends BasePresenter<SubscribeViewModel> {
  SubscribePresenter(SubscribeViewModel model) : super(model);

  bool switchBool = true;
  bool notComplete = false;

  void initCompany(Company company, String campany) {
    model.company = company;
    model.campany = campany;
  }

  void onChanged(bool value) {
    switchBool = value;
    updateView();
  }

  void openContract() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContractScreen()));
  }

  void cardLinkNavigator() async {
    CardModel? cardModel = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const LinkCardScreen(),
      ),
    );
    if (cardModel != null) {
      model.cardModel = cardModel;
    }
    updateView();
  }

  //TODO: NEED TO OPTIMIZE

  void submit() async {
    if (validate()) {
      startLoading();
      if (model.isLoading) {
        Popups.showPopup(
          title: "Проверяем документы",
          description: "Это займет не больше минуты",
          context: context,
          isLoading: true,
        );
      }
      notComplete = false;
      if (userScope.userData.documents.isEmpty) {
        List<File> images = [];
        images.add(File(model.idFront!.path));
        images.add(File(model.idBack!.path));
        images.add(File(model.driverLicenceFront!.path));
        images.add(File(model.driverLicenceBack!.path));
        List<String> urls = await PhotoUploader(userScopeData: userScope).uploadImageFile(images);
        await FireStoreInstance().updateUserData(uid: userScope.userData.uid, documents: urls);
      }
      await FireStoreInstance().sendRequest(
        uid: userScope.userData.uid,
        company: model.company!.name,
        price: model.campany!,
      );
      if (userScope.userData.cardModel.cardNumber.isEmpty ||
          userScope.userData.cardModel.cardHolder.isEmpty) {
        await FireStoreInstance().updateUserData(
          uid: userScope.userData.uid,
          cardModel: model.cardModel,
        );
      }
      updateView();
      endLoading();
      UserData? userData = await FireStoreInstance().fetchUserData(uid: userScope.userData.uid);
      if (userData != null) {
        await SharedPreferencesRepository().addUserData(userData);
        userScope.userData = userData;
      }
      Navigator.pop(context);
      Popups.showPopup(
        title: "Спасибо!",
        description: "Ваша заявка отправлена!\nМы с вами скоро свяжемся!",
        buttonText: "Ok",
        context: context,
      );
    } else {
      notComplete = true;
      updateView();
    }
  }

  bool validate() {
    if (userScope.userData.documents.isNotEmpty &&
        userScope.userData.cardModel.cardNumber.isNotEmpty &&
        userScope.userData.cardModel.cardHolder.isNotEmpty) {
      return true;
    }
    if ((model.idFront == null ||
            model.idBack == null ||
            model.driverLicenceBack == null ||
            model.driverLicenceFront == null) ||
        switchBool == false ||
        model.cardModel == null) {
      return false;
    }
    return true;
  }

  void uploadDocument(int i) async {
    final photo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePhotoScreen(
                  flag: i,
                )));
    if (i == 0) {
      model.idFront = photo;
    } else if (i == 1) {
      model.idBack = photo;
    } else if (i == 2) {
      model.driverLicenceFront = photo;
    } else if (i == 3) {
      model.driverLicenceBack = photo;
    }
    updateView();
  }
}
