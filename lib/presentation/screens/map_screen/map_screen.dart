import 'dart:async';
import 'dart:io';

import 'package:ad_drive/data/directions_repository.dart';
import 'package:ad_drive/model/directions.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_presenter.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with AutomaticKeepAliveClientMixin {
  final MapPresenter _presenter = MapPresenter(MapViewModel(ScreenState.none));

  StreamSubscription? _locationSubscription;
  final Location _locationTracker = Location();
  Marker? marker;
  GoogleMapController? _controller;
  Directions? _info;
  static const CameraPosition initialLocation = CameraPosition(target: LatLng(37, -122), zoom: 14);
  LatLng lastLocation = const LatLng(37, -122);

  void updateMarker(LocationData newLocationData) {
    if (newLocationData.longitude != null &&
        newLocationData.latitude != null &&
        newLocationData.heading != null &&
        newLocationData.accuracy != null) {
      LatLng latLng = LatLng(newLocationData.latitude!, newLocationData.longitude!);
      setState(() {});
      marker = Marker(
          markerId: const MarkerId(
            "home",
          ),
          position: latLng,
          rotation: newLocationData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    }
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();
      updateMarker(location);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged
          .throttleTime(const Duration(seconds: 60))
          .listen((event) async {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(
                event.latitude!,
                event.longitude!,
              ),
              tilt: 0,
              zoom: 18,
              bearing: 192)));
          final directions = await DirectionsRepository().getDirections(
              origin: lastLocation, destination: LatLng(event.latitude!, event.longitude!));
          setState(() {
            lastLocation = LatLng(event.latitude!, event.longitude!);
            _info = directions;
          });
        }
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void didChangeDependencies() {
    _presenter.initWithContext(context);
    getCurrentLocation();
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
                  initialCameraPosition: initialLocation,
                  markers: Set.of(marker != null ? [marker!] : []),
                  onMapCreated: (controller) => _controller = controller,
                  polylines: {
                    if (_info != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: AppColors.PRIMARY_BLUE,
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      ),
                  },
                ),
                if (_info != null)
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_BLUE,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Text(
                        '${_info!.totalDistance}, ${_info!.totalDuration}',
                        style: const TextStyle(
                          color: AppColors.MONO_WHITE,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, right: 5),
                      child: FloatingActionButton(
                        child: const Icon(Icons.location_searching),
                        onPressed: () {
                          getCurrentLocation();
                        },
                      ),
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
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            children: [
                              Text(
                                "Monday",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: AppColors.MONO_WHITE,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "October 18, 2021",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.MONO_WHITE,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.location_on_rounded,
                                        color: AppColors.MONO_WHITE,
                                      ),
                                      Text(
                                        "Distance",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.MONO_WHITE,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "1589 km",
                                        style: TextStyle(
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
                                    children: const [
                                      Icon(
                                        Icons.monetization_on_outlined,
                                        color: AppColors.MONO_WHITE,
                                      ),
                                      Text(
                                        "Money",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.MONO_WHITE,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "50 \$",
                                        style: TextStyle(
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
                                    children: const [
                                      Icon(
                                        Icons.timer,
                                        color: AppColors.MONO_WHITE,
                                      ),
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.MONO_WHITE,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "02 : 59",
                                        style: TextStyle(
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
                          decoration:
                              BoxDecoration(color: AppColors.MONO_WHITE, borderRadius: radius),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.monetization_on_outlined,
                                    color: AppColors.PRIMARY_BLUE,
                                  ),
                                  Text(
                                    "Earnings for today:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                  child: Text(
                                    "50 \$",
                                    style: TextStyle(
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
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
