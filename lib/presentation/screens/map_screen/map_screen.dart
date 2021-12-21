import 'dart:io';

import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_presenter.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with AutomaticKeepAliveClientMixin {
  final MapPresenter _presenter = MapPresenter(MapViewModel(ScreenState.none));

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return StreamBuilder<MapViewModel>(
        stream: _presenter.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  mapType: MapType.hybrid,
                  initialCameraPosition: _presenter.initialLocation,
                  markers: Set.of(_presenter.marker != null ? [_presenter.marker!] : []),
                  onMapCreated: (controller) => _presenter.controller = controller,
                  polylines: _presenter.lines,
                ),
                SlidingUpPanel(
                  minHeight: 150,
                  maxHeight: 600,
                  panel: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.PRIMARY_BLUE,
                            AppColors.PRIMARY_BLUE.withOpacity(0.97),
                            AppColors.PRIMARY_BLUE.withOpacity(0.95),
                            AppColors.PRIMARY_BLUE.withOpacity(0.93),
                            AppColors.PRIMARY_BLUE.withOpacity(0.90),
                            AppColors.PRIMARY_BLUE.withOpacity(0.85),
                            AppColors.PRIMARY_BLUE.withOpacity(0.8),
                            AppColors.PRIMARY_BLUE.withOpacity(0.75),
                            AppColors.PRIMARY_BLUE.withOpacity(0.55),
                            AppColors.PRIMARY_BLUE.withOpacity(0.35),
                          ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('EEEE').format(DateTime.now()).toString(),
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 30,
                                color: AppColors.MONO_WHITE,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat("y-MMMM-d").format(DateTime.now()).toString(),
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.MONO_WHITE,
                                  ),
                                  const Text(
                                    "Distance",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 24,
                                        color: AppColors.MONO_WHITE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    _presenter.totalDistance.toInt().toString() + " miles",
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 24,
                                      color: AppColors.MONO_WHITE,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: AppColors.MONO_WHITE,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    color: AppColors.MONO_WHITE,
                                  ),
                                  const Text(
                                    "Money",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 24,
                                        color: AppColors.MONO_WHITE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    (_presenter.totalDistance.toInt() * 50).toString() + " \$",
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 24,
                                      color: AppColors.MONO_WHITE,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomButton(
                            title: "Start drive",
                            onClick: _presenter.takePhoto,
                            textColor: AppColors.PRIMARY_BLUE,
                            backgroundColor: AppColors.MONO_WHITE,
                          ),
                          if (_presenter.model.photo != null)
                            Image.file(
                              File(_presenter.model.photo!.path),
                              height: 200,
                            ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(
                      padding: EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16,
                          bottom: MediaQuery.of(context).padding.bottom + 16),
                      decoration: BoxDecoration(color: AppColors.MONO_WHITE, borderRadius: radius),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              Icon(
                                Icons.monetization_on_outlined,
                                color: AppColors.PRIMARY_BLUE,
                              ),
                              Text(
                                "Earnings for today:",
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.PRIMARY_BLUE,
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.PRIMARY_BLUE.withOpacity(0.85),
                                      AppColors.PRIMARY_BLUE.withOpacity(0.9),
                                      AppColors.PRIMARY_BLUE,
                                      AppColors.PRIMARY_BLUE.withOpacity(0.9),
                                      AppColors.PRIMARY_BLUE.withOpacity(0.85),
                                      AppColors.PRIMARY_BLUE.withOpacity(0.8),
                                      AppColors.PRIMARY_BLUE.withOpacity(0.75),
                                    ],
                                  )),
                              child: const Text(
                                "50 \$",
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: AppColors.MONO_WHITE,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ],
                      )),
                  borderRadius: radius,
                ),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
