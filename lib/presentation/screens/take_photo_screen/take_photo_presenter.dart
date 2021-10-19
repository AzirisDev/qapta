import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoPresenter extends BasePresenter<TakePhotoViewModel> {
  TakePhotoPresenter(TakePhotoViewModel model) : super(model);

  final ImagePicker _picker = ImagePicker();

  void takePicture() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context, photo);
    updateView();
  }
}
