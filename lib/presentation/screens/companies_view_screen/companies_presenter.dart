import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'companies_view_model.dart';

class CompaniesPresenter extends BasePresenter<CompaniesViewModel> {
  CompaniesPresenter(CompaniesViewModel model) : super(model);

  List<Company> companies = [
    Company(
        name: "Apple Inc.",
        logo: "assets/icons/apple_logo.svg",
        oneMonth: 65,
        threeMonth: 155,
        sixMonth: 456),
    Company(
        name: "Tesla Motors",
        logo: "assets/icons/tesla_motors_logo.svg",
        oneMonth: 80,
        threeMonth: 200,
        sixMonth: 560),
    Company(
        name: "Coca-Cola",
        logo: "assets/icons/coca_cola_logo.svg",
        oneMonth: 55,
        threeMonth: 134,
        sixMonth: 452),
    Company(
        name: "Amazon Inc.",
        logo: "assets/icons/amazon_logo.svg",
        oneMonth: 35,
        threeMonth: 155,
        sixMonth: 406),
    Company(
        name: "Harley Davidson",
        logo: "assets/icons/harley_davidson_logo.svg",
        oneMonth: 45,
        threeMonth: 195,
        sixMonth: 696),
    Company(
        name: "Bitcoin",
        logo: "assets/icons/bitcoin_logo.svg",
        oneMonth: 1,
        threeMonth: 2,
        sixMonth: 9999),
    Company(
        name: "Bitcoin",
        logo: "assets/icons/bitcoin_logo.svg",
        oneMonth: 1,
        threeMonth: 2,
        sixMonth: 9999),
    Company(
        name: "Bitcoin",
        logo: "assets/icons/bitcoin_logo.svg",
        oneMonth: 1,
        threeMonth: 2,
        sixMonth: 9999),
  ];

  void onCompanyClick(Company company) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CompanyProfile(company: company)));
  }
}
