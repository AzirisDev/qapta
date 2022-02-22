import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/model/card.dart';
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
  final String campany;

  const SubscribeScreen({Key? key, required this.company, required this.campany}) : super(key: key);

  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final SubscribePresenter _presenter = SubscribePresenter(SubscribeViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    _presenter.initCompany(widget.company, widget.campany);
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
                    _presenter.model.idFront,
                    "Передняя сторона Удостоверение личности",
                    0,
                    _presenter.userScope.userData.documents.isNotEmpty,
                  ),
                  photoCard(
                    _presenter.model.idBack,
                    "Задняя сторона Удостоверение личности",
                    1,
                    _presenter.userScope.userData.documents.isNotEmpty,
                  ),
                  photoCard(
                    _presenter.model.driverLicenceFront,
                    "Передняя сторона Водительских прав",
                    2,
                    _presenter.userScope.userData.documents.isNotEmpty,
                  ),
                  photoCard(
                    _presenter.model.driverLicenceBack,
                    "Задняя сторона Водительских прав",
                    3,
                    _presenter.userScope.userData.documents.isNotEmpty,
                  ),
                  if (_presenter.userScope.userData.cardModel.cardNumber.isEmpty)
                    subscribeTile(
                      'Введите данные вашей карты',
                      _presenter.cardLinkNavigator,
                      _presenter.model.cardModel,
                    ),
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
                  const SizedBox(
                    height: 12,
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
            backgroundColor: AppColors.MONO_WHITE,
          );
        });
  }

  Widget photoCard(XFile? photo, String text, int flag, bool hasDocument) {
    return GestureDetector(
      onTap: () {
        if (!hasDocument) {
          _presenter.uploadDocument(flag);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ]),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                child: photo != null || hasDocument
                    ? const Icon(
                        Icons.check_box,
                        color: AppColors.PRIMARY_BLUE,
                        size: 50,
                      )
                    : Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.MONO_BLACK.withOpacity(0.65),
                        size: 50,
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget subscribeTile(String title, void Function() onClick, CardModel? cardModel) {
  return InkWell(
    onTap: onClick,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ]),
              child: Row(
                children: [
                  SizedBox(
                      height: 50,
                      child: cardModel != null
                          ? const Icon(
                              Icons.check_box,
                              color: AppColors.PRIMARY_BLUE,
                              size: 50,
                            )
                          : null),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
