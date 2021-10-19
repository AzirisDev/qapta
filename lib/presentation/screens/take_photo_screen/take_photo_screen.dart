import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_presenter.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_view_model.dart';
import 'package:flutter/material.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({Key? key}) : super(key: key);

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  TakePhotoPresenter _presenter = TakePhotoPresenter(TakePhotoViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MONO_WHITE,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.PRIMARY_BLUE,
          ),
        ),
      ),
      child: Column(
        children: [
          Spacer(),
          Image.asset("assets/main_images/take_photo_car.jpg"),
          Spacer(),
          CustomButton(title: "Take photo", onClick: _presenter.takePicture)
        ],
      ),
      backgroundColor: AppColors.MONO_WHITE,
    );
  }
}
