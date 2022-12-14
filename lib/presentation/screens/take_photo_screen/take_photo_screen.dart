import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_presenter.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_view_model.dart';
import 'package:flutter/material.dart';

class TakePhotoScreen extends StatefulWidget {
  final int flag;

  const TakePhotoScreen({Key? key, required this.flag}) : super(key: key);

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  final TakePhotoPresenter _presenter = TakePhotoPresenter(TakePhotoViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GeneralScaffold(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.flag == 4)
                const Text(
                  "Сфотографируйте автомобиль",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.PRIMARY_BLUE,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway',
                  ),
                ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(widget.flag == 0
                      ? "assets/main_images/id_front.jpg"
                      : widget.flag == 1
                          ? "assets/main_images/id_back.jpg"
                          : widget.flag == 2
                              ? "assets/main_images/driver_licence_front.jpg"
                              : widget.flag == 3
                                  ? "assets/main_images/driver_licence_back.jpg"
                                  : "assets/main_images/ad_example.png")),
              const Spacer(),
              if (widget.flag == 4)
                const Text(
                  "*нам нужно убедиться, что выездите с нашей рекламой и мы начислим вам деньги",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.PRIMARY_BLUE,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway',
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomButton(title: "Сфотографировать", onClick: _presenter.takePicture))
            ],
          ),
        ),
        backgroundColor: AppColors.MONO_WHITE,
      ),
    );
  }
}
