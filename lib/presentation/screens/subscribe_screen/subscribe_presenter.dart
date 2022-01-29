import 'dart:io';

import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/card.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
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

  void initCompany(Company company, int index) {
    model.company = company;
    model.index = index;
  }

  void onChanged(bool value) {
    switchBool = value;
    updateView();
  }

  void openContract() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContractScreen()));
  }

  void cardLinkNavigator() async {
    CardModel? cardModel = await Navigator.push(context, CupertinoPageRoute(builder: (context) => const LinkCardScreen(),),);
    if(cardModel != null){
      model.cardModel = cardModel;
    }
    updateView();
  }

  //TODO: NEED TO OPTIMIZE

  void submit() async {
    if (validate()) {
      DateTime time = DateTime.now();
      startLoading();
      notComplete = false;
      List<File> images = [];
      images.add(File(model.idFront!.path));
      images.add(File(model.idBack!.path));
      images.add(File(model.driverLicenceFront!.path));
      images.add(File(model.driverLicenceBack!.path));
      await PhotoUploader(userScopeData: userScope).uploadImageFile(images);
      print("-----------------");
      print(DateTime.now().difference(time).inSeconds.toString());
      print("-----------------");
      FireStoreInstance().sendRequest(userScope.userData.uid, model.company!.name,
          model.company!.prices.keys.elementAt(model.index!));
      updateView();
      endLoading();
    } else {
      notComplete = true;
      updateView();
    }
  }

  bool validate() {
    if (model.idFront == null ||
        model.idBack == null ||
        model.driverLicenceBack == null ||
        model.driverLicenceFront == null ||
        switchBool == false) {
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
