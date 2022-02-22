import 'package:ad_drive/contants/app_colors.dart';
import 'package:ad_drive/model/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyListItem extends StatelessWidget {
  final Company company;
  final void Function() onClick;

  const CompanyListItem({Key? key, required this.company, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 100,
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.MONO_WHITE,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      company.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${company.prices.values.last} KZT",
                      style: const TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black26,
                          ),
                        ],
                        fontSize: 17,
                        fontFamily: 'Raleway',
                        color: AppColors.PRIMARY_BLUE,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              width: 100,
              padding: EdgeInsets.zero,
              child: SvgPicture.network(company.logo),
            ),
          ],
        ),
      ),
    );
  }
}
