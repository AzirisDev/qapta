import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_view_model.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyProfile extends StatefulWidget {
  final Company company;

  const CompanyProfile({Key? key, required this.company}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  final CompanyPresenter _presenter = CompanyPresenter(CompanyViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.model.company = widget.company;
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Company company = _presenter.model.company;
    return StreamBuilder<CompanyViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return GeneralScaffold(
              appBar: customAppBar(title: 'О компании'),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.PRIMARY_BLUE.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(50),
                              height: 250,
                              width: 250,
                              child: SvgPicture.asset(company.logo)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        company.name,
                        style: const TextStyle(
                            fontFamily: 'Railway', fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      const Text(
                        'Описание',
                        style: TextStyle(
                            fontFamily: 'Raleway', fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        company.description,
                        maxLines: _presenter.isExpand ? null : 4,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: _presenter.expandText,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                _presenter.isExpand ? "Open" : "Close",
                                style: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(_presenter.isExpand
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                      ),
                      const Text(
                        'Выбрать варианты рекламы',
                        style: TextStyle(
                            fontFamily: 'Raleway', fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: company.prices.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _presenter.onTapInfoContainer(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _presenter.index == index
                                      ? AppColors.PRIMARY_BLUE
                                      : AppColors.MONO_WHITE,
                                  border: Border.all(color: AppColors.PRIMARY_BLUE, width: 1),
                                ),
                                margin: const EdgeInsets.only(right: 5, left: 5),
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                child: Center(
                                  child: Text(
                                    _presenter.adverts[index],
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      color: _presenter.index != index
                                          ? AppColors.PRIMARY_BLUE
                                          : AppColors.MONO_WHITE,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    company.prices.values.elementAt(_presenter.index).toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    ' KZT/час',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                  title: "Подписаться",
                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SubscribeScreen(company: company, index: _presenter.index,)));
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white);
        });
  }
}
