import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyProfile extends StatefulWidget {
  final Company company;

  const CompanyProfile({Key? key, required this.company}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  CompanyPresenter _presenter = CompanyPresenter(CompanyViewModel(ScreenState.None));

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
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.black,
                      ),
                    ),
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.symmetric(vertical: 5),
                      title: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          company.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      background: Container(
                        padding: EdgeInsets.all(70),
                        child: SvgPicture.asset(
                          company.logo,
                          clipBehavior: Clip.hardEdge,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 40,
                          ),
                          Text(
                            company.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            height: 40,
                          ),
                          Image(image: AssetImage("assets/main_images/ad_example.png")),
                          Divider(
                            height: 40,
                          ),
                          Container(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: company.prices.length,
                              itemBuilder: (context, index) {
                                List<String> months = company.prices.keys.toList();
                                return GestureDetector(
                                  onTap: () {
                                    _presenter.onTapInfoContainer(index);
                                  },
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: _presenter.index == index
                                          ? Colors.blue.withOpacity(0.1)
                                          : Colors.white,
                                      border: Border.all(
                                          color:
                                              _presenter.index == index ? Colors.blue : Colors.grey,
                                          width: 1),
                                    ),
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          months[index],
                                          style: TextStyle(
                                            color: _presenter.index == index
                                                ? Colors.blue
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${company.prices[months[index]].toString()} \$",
                                          style: TextStyle(
                                            color: _presenter.index == index
                                                ? Colors.blue
                                                : Colors.black,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          CustomButton(title: "Subscribe", onClick: () {}),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.white);
        });
  }
}
