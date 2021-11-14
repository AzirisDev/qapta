import 'dart:io';

import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/helpers/photo_uploader.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_view_model.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/widgets/contract_screen.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_screen.dart';
import 'package:flutter/material.dart';

class SubscrivePresenter extends BasePresenter<SubscribeViewModel> {
  SubscrivePresenter(SubscribeViewModel model) : super(model);

  bool switchBool = true;
  bool notComplete = false;

  void onChanged(bool value) {
    switchBool = value;
    updateView();
  }

  void openContract() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContractScreen()));
  }

  void submit() {
    if (validate()) {
      notComplete = false;
      List<File> images = [];
      images.add(File(model.idFront!.path));
      images.add(File(model.idBack!.path));
      images.add(File(model.driverLicenceFront!.path));
      images.add(File(model.driverLicenceBack!.path));
      PhotoUploader().uploadImageFile(images);
      updateView();
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
