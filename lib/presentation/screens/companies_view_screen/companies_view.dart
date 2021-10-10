import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/companies_view_screen/widgets/company_list_item.dart';
import 'package:flutter/material.dart';

import 'companies_presenter.dart';
import 'companies_view_model.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final CompaniesPresenter _presenter = CompaniesPresenter(CompaniesViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: AppColors.PRIMARY_BLUE, borderRadius: BorderRadius.circular(12)),
            child: const Center(
              child: Text(
                "Companies",
                style: TextStyle(
                  color: AppColors.MONO_WHITE,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          backgroundColor: AppColors.MONO_WHITE,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _presenter.companies.length,
              itemBuilder: (context, index) {
                Company company = _presenter.companies[index];
                return CompanyListItem(
                  company: company,
                  onClick: () {
                    _presenter.onCompanyClick(company);
                  },
                );
              }),
        ),
        backgroundColor: Colors.white);
  }
}
