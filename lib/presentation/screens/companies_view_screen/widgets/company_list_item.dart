import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyListItem extends StatelessWidget {
  final Company company;
  final void Function() onClick;
  const CompanyListItem({Key? key, required this.company, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.MONO_WHITE,
            border: Border.all(
              color: AppColors.PRIMARY_BLUE,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  company.logo,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Container(
                width: 1,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.PRIMARY_BLUE,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: company.prices.length,
                      itemBuilder: (context, index) {
                        List<String> months = company.prices.keys.toList();
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_money.svg",
                                    ),
                                  ),
                                  Text(
                                    months[index],
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${company.prices[months[index]].toString()} \$",
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
