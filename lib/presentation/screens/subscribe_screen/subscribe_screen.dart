import 'dart:io';

import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_presenter.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final SubscrivePresenter _presenter = SubscrivePresenter(SubscribeViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubscribeViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
            appBar: customAppBar(title: "Подписка"),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "Photo uploading".toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        color: AppColors.PRIMARY_BLUE,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  photoCard(_presenter.model.idFront, "Front side of ID card", 0),
                  photoCard(_presenter.model.idBack, "Back side of ID card", 1),
                  photoCard(
                      _presenter.model.driverLicenceFront, "Front side of driver's licence", 2),
                  photoCard(_presenter.model.driverLicenceBack, "Back side of driver's licence", 3),
                  SwitchListTile(
                    title: GestureDetector(
                      onTap: _presenter.openContract,
                      child: const Text(
                        'I accept terms of Contract',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    value: _presenter.switchBool,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.PRIMARY_BLUE,
                    inactiveTrackColor: Colors.grey,
                    onChanged: _presenter.onChanged,
                  ),
                  CustomButton(
                    title: _presenter.notComplete ? "Fill form" : "Submit",
                    onClick: _presenter.submit,
                    backgroundColor:
                        _presenter.notComplete ? AppColors.MONO_RED : AppColors.PRIMARY_BLUE,
                    borderColor:
                        _presenter.notComplete ? AppColors.MONO_RED : AppColors.PRIMARY_BLUE,
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.MONO_WHITE,
          );
        });
  }

  Widget photoCard(XFile? photo, String text, int flag) {
    return GestureDetector(
      onTap: () {
        _presenter.uploadDocument(flag);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: photo != null
                  ? Image.file(File(photo.path))
                  : const Icon(
                      Icons.camera_alt_rounded,
                      size: 75,
                    ),
            ),
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
