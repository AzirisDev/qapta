import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_profile.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'companies_view_model.dart';

class CompaniesPresenter extends BasePresenter<CompaniesViewModel> {
  CompaniesPresenter(CompaniesViewModel model) : super(model);

  TextEditingController searchController = TextEditingController();

  final List<Company> _allCompanies = [];

  final searchOnChange = BehaviorSubject<String>();

  @override
  void onInitWithContext() {
    super.onInitWithContext();
    fetchCompanies();
    searchOnChange.debounceTime(const Duration(milliseconds: 600)).listen((queryString) {
      onSearchClick();
    });
  }

  void onSearchChanged(String text) {
    searchOnChange.add(text);
    updateView();
  }

  void onSearchClick() async {
    model.companies = null;
    updateView();
    model.companies = [];
    for(Company element in _allCompanies){
      if(element.name.toLowerCase().contains(searchController.text.toLowerCase())){
        model.companies!.add(element);
      }
    }
    model.companies ??= [];
    updateView();
  }

  void fetchCompanies() async {
    model.companies = await FireStoreInstance().fetchCompanies();
    model.companies?.forEach((element) {
      _allCompanies.add(element);
    });
    updateView();
  }

  void onCompanyClick(Company company) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CompanyProfile(company: company)));
  }
}
