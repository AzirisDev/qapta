import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_view_model.dart';
import 'package:ad_drive/presentation/screens/subscribe_screen/subscribe_screen.dart';
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
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.black,
                      ),
                    ),
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.symmetric(vertical: 5),
                      title: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          company.name,
                          style: const TextStyle(fontFamily: 'Raleway',color: Colors.black),
                        ),
                      ),
                      background: Container(
                        padding: const EdgeInsets.all(70),
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
                          const Text(
                            "About",
                            style: TextStyle(fontFamily: 'Raleway',fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            height: 40,
                          ),
                          Text(
                            company.description,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                          ),
                          const Divider(
                            height: 40,
                          ),
                          const Image(image: AssetImage("assets/main_images/ad_example.png")),
                          const Divider(
                            height: 40,
                          ),
                          SizedBox(
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
                                    margin: const EdgeInsets.only(right: 5, left: 5),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          months[index],
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
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
                                            fontFamily: 'Raleway',
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
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomButton(
                                  title: "Subscribe",
                                  onClick: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const SubscribeScreen()));
                                  })),
                          const SizedBox(
                            height: 10,
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
