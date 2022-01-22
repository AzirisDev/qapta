import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'companies_view_model.dart';

class CompaniesPresenter extends BasePresenter<CompaniesViewModel> {
  CompaniesPresenter(CompaniesViewModel model) : super(model);

  List<Company> companies = [
    Company(
      name: "Apple Inc.",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/apple_logo.svg",
      prices: {"1 month": 65, "3 month": 155, "6 month": 456},
    ),
    Company(
      name: "Tesla Motors",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/tesla_motors_logo.svg",
      prices: {"1 month": 80, "3 month": 200, "6 month": 560},
    ),
    Company(
      name: "Coca-Cola",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/coca_cola_logo.svg",
      prices: {"1 month": 55, "3 month": 134, "6 month": 452},
    ),
    Company(
      name: "Amazon Inc.",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/amazon_logo.svg",
      prices: {"1 month": 35, "3 month": 155, "6 month": 406},
    ),
    Company(
      name: "Harley Davidson",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/harley_davidson_logo.svg",
      prices: {"1 month": 45, "3 month": 195, "6 month": 696},
    ),
    Company(
      name: "Bitcoin",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/bitcoin_logo.svg",
      prices: {"1 month": 1, "3 month": 2, "6 month": 999},
    ),
    Company(
      name: "Bitcoin",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/bitcoin_logo.svg",
      prices: {"1 month": 1, "3 month": 2, "6 month": 999},
    ),
    Company(
      name: "Bitcoin",
      description: lorem(words: 60, paragraphs: 2),
      logo: "assets/icons/bitcoin_logo.svg",
      prices: {"1 month": 1, "3 month": 2, "6 month": 999},
    ),
  ];

  @override
  void onInitWithContext() {
    super.onInitWithContext();
    fetchCompanies();
  }

  void fetchCompanies() async {
    await FireStoreInstance().fetchCompanies();
  }

  void onCompanyClick(Company company) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CompanyProfile(company: company)));
  }
}
