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
  CompaniesPresenter _presenter = CompaniesPresenter(CompaniesViewModel(ScreenState.None));

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
          title: Text(
            "Compaines",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
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
