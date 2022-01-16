import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_presenter.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapPresenter _presenter = MapPresenter(MapViewModel(ScreenState.none));

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

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
                  minHeight: 100,
                  maxHeight: 360,
                  backdropEnabled: true,
                  backdropColor: Colors.black,
                  panel: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMd('ru').format(DateTime.now()).toString(),
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 32,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: AppColors.MONO_WHITE,
                          ),
                          const Text(
                            "Ваш заработок за сегодня",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                color: AppColors.MONO_WHITE,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            (_presenter.totalDistance.toInt() * 50).toString() + " KZT",
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 32,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Пройденный путь",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                color: AppColors.MONO_WHITE,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            _presenter.totalDistance.toInt().toString() + " километров",
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 32,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                          const Divider(
                            color: AppColors.MONO_WHITE,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Завершить поездку',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 24,
                                  color: AppColors.MONO_WHITE,
                                ),
                              ),
                              GestureDetector(
                                onTap: _presenter.endRide,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.PRIMARY_BLUE,
                                    border: Border.all(color: AppColors.MONO_WHITE, width: 4),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(
                                          0.0,
                                          0.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'X',
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.MONO_WHITE),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(
                      padding: EdgeInsets.only(
                          top: 16,
                          left: 32,
                          right: 32,
                          bottom: MediaQuery.of(context).padding.bottom + 16),
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_BLUE,
                        borderRadius: radius,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Начать поездку',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 24,
                              color: AppColors.MONO_WHITE,
                            ),
                          ),
                          GestureDetector(
                            onTap: _presenter.takePhoto,
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.PRIMARY_BLUE,
                                border: Border.all(color: AppColors.MONO_WHITE, width: 4),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      0.0,
                                      0.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.MONO_WHITE,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      )),
                  borderRadius: radius,
                ),
              ],
            ),
          );
        });
  }
}
