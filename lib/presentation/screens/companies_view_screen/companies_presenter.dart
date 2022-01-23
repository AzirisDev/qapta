import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_profile.dart';
import 'package:flutter/material.dart';

import 'companies_view_model.dart';

class CompaniesPresenter extends BasePresenter<CompaniesViewModel> {
  CompaniesPresenter(CompaniesViewModel model) : super(model);

  @override
  void onInitWithContext() {
    super.onInitWithContext();
    fetchCompanies();
  }

  void fetchCompanies() async {
    model.companies = await FireStoreInstance().fetchCompanies();
    updateView();
  }

  void onCompanyClick(Company company) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CompanyProfile(company: company)));
  }
}
