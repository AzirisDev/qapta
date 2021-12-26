import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/companies_view_screen/widgets/company_list_item.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Каталог",
          style: appBarTextStyle,
        ),
      ),
      backgroundColor: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              cursorColor: Colors.blue,
              cursorHeight: 20,
              controller: TextEditingController(),
              cursorWidth: 1.5,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                hintText: 'Название компании',
                hintStyle: TextStyle(
                  fontFamily: 'RaleWay',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // Expanded(
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: const BouncingScrollPhysics(),
            //       itemCount: _presenter.companies.length,
            //       itemBuilder: (context, index) {
            //         Company company = _presenter.companies[index];
            //         return CompanyListItem(
            //           company: company,
            //           onClick: () {
            //             _presenter.onCompanyClick(company);
            //           },
            //         );
            //       }),
            // ),
            Expanded(
              child: GridView.builder(
                itemCount: _presenter.companies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Company company = _presenter.companies[index];
                  return CompanyListItem(
                    company: company,
                    onClick: () {
                      _presenter.onCompanyClick(company);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
