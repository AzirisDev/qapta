import 'dart:async';
import 'dart:io';
import 'dart:math' show cos, sqrt, asin;

import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/helpers/get_job_available.dart';
import 'package:ad_drive/presentation/helpers/photo_uploader.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:ad_drive/presentation/screens/take_photo_screen/take_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app_colors.dart';

class MapPresenter extends BasePresenter<MapViewModel> {
  MapPresenter(MapViewModel model) : super(model);

  StreamSubscription? locationSubscription;
  StreamSubscription<Position>? positionStream;
  final Location _locationTracker = Location();
  Marker? marker;
  GoogleMapController? controller;
  final Set<Polyline> lines = {};
  List<LatLng> locationListFromStream = [];
  int polylineIdCounter = 0;
  CameraPosition initialLocation = const CameraPosition(target: LatLng(43, 76), zoom: 14);
  LatLng lastLocation = const LatLng(43, 76);
  double totalDistance = 0;
  bool isJobAvailable = false;

  @override
  void onInitWithContext() async {
    super.onInitWithContext();
    if (getJobAvailable()) {
      await getCurrentLocation();
    }
  }

  bool getJobAvailable() {
    bool canWork = JobAvailability().getJobAvailable();
    if (canWork) {
      isJobAvailable = true;
      updateView();
    } else {
      isJobAvailable = false;
      updateView();
    }
    return canWork;
  }

  void startTracking() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (locationListFromStream.isNotEmpty) {
        totalDistance += Geolocator.distanceBetween(
          locationListFromStream.last.latitude,
          locationListFromStream.last.longitude,
          position.latitude,
          position.longitude,
        );
      }
      locationListFromStream.add(LatLng(position.latitude, position.longitude));
    });
  }

  Future getCurrentLocation() async {
    var location = await _locationTracker.getLocation();
    updateMarker(location);
    lastLocation = LatLng(location.latitude!, location.longitude!);
    try {
      locationSubscription = _locationTracker.onLocationChanged
          .throttleTime(const Duration(seconds: 5))
          .listen((event) async {
        if (controller != null) {
          var location = await _locationTracker.getLocation();
          if (lastLocation.latitude != location.latitude &&
              lastLocation.longitude != location.longitude) {
            updateMarker(location);
            List<LatLng> list = locationListFromStream.toList();
            controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(
                  event.latitude!,
                  event.longitude!,
                ),
                tilt: 0,
                zoom: 18,
                bearing: 192)));
            polylineIdCounter++;
            lines.add(Polyline(
              polylineId: PolylineId(polylineIdCounter.toString()),
              color: AppColors.PRIMARY_BLUE,
              width: 5,
              points: list,
            ));
            locationListFromStream.clear();
            lastLocation = LatLng(location.latitude!, location.longitude!);
            updateView();
          }
        }
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrint("Permission Denied");
      }
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a =
        0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void updateMarker(LocationData newLocationData) {
    if (newLocationData.longitude != null &&
        newLocationData.latitude != null &&
        newLocationData.heading != null) {
      LatLng latLng = LatLng(newLocationData.latitude!, newLocationData.longitude!);
      updateView();
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

  void endRide() async {
    cancelStreams();
    final photoUrl = await getUploadPhoto();
    await FireStoreInstance().sendFinishRide(userScope.userData.uid, photoUrl, totalDistance.toInt());
  }

  void takePhoto() async {
    final photoUrl = await getUploadPhoto();
    await FireStoreInstance().sendStartRide(userScope.userData.uid, photoUrl);
    startTracking();
    updateView();
  }

  Future<String> getUploadPhoto() async {
    final photo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TakePhotoScreen(
              flag: 4,
            )));
    List<String> photoUrl = await PhotoUploader(userScopeData: userScope).uploadImageFile([File(photo.path)]);
    return photoUrl.first;
  }

  void cancelStreams(){
    if (locationSubscription != null) {
      locationSubscription!.cancel();
    }
    if (positionStream != null) {
      positionStream!.cancel();
    }
  }

  @override
  void dispose() {
    cancelStreams();
    super.dispose();
  }
}
