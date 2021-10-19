import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_screen.dart';
import 'package:flutter/material.dart';

class MapPresenter extends BasePresenter<MapViewModel> {
  MapPresenter(MapViewModel model) : super(model);

  void takePhoto() async {
    final photo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePhotoScreen(
                  flag: 4,
                )));
    model.photo = photo;
    updateView();
  }
}
