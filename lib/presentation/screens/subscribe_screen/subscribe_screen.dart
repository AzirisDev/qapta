import 'dart:io';

import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_presenter.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SubscribeScreen extends StatefulWidget {
  final Company company;
  final int index;

  const SubscribeScreen({Key? key, required this.company, required this.index}) : super(key: key);

  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final SubscribePresenter _presenter = SubscribePresenter(SubscribeViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    _presenter.initCompany(widget.company, widget.index);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubscribeViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
            appBar: customAppBar(title: "Подписка"),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          'Сфотограцируйте ваши документы',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: AppColors.MONO_BLACK,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      photoCard(
                          _presenter.model.idFront, "Передняя сторона Удостоверение личности", 0),
                      photoCard(
                          _presenter.model.idBack, "Задняя сторона Удостоверение личности", 1),
                      photoCard(_presenter.model.driverLicenceFront,
                          "Передняя сторона Водительских прав", 2),
                      photoCard(_presenter.model.driverLicenceBack,
                          "Передняя сторона Водительских прав", 3),
                      SwitchListTile(
                        title: GestureDetector(
                          onTap: _presenter.openContract,
                          child: const Text(
                            'Я принимаю условия Пользования',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
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
                        showLoading: false,
                        title: _presenter.notComplete ? "Заполните форму" : "Рекламировать",
                        onClick: _presenter.submit,
                        backgroundColor: _presenter.notComplete
                            ? AppColors.MONO_RED.withOpacity(0.7)
                            : AppColors.PRIMARY_BLUE,
                        borderColor: _presenter.notComplete
                            ? AppColors.MONO_RED.withOpacity(0.7)
                            : AppColors.PRIMARY_BLUE,
                      ),
                    ],
                  ),
                ),
                if (_presenter.model.isLoading)
                  Container(
                    color: AppColors.MONO_GREY.withOpacity(0.5),
                    child: const Center(
                      child: SizedBox(
                        width: 75,
                        height: 75,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.PRIMARY_BLUE,
                        ),
                      ),
                    ),
                  )
              ],
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
                  ? const Icon(
                      Icons.check_box,
                      color: AppColors.PRIMARY_BLUE,
                      size: 75,
                    )
                  : Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.MONO_BLACK.withOpacity(0.65),
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
