import 'dart:async';
import 'dart:io';
import 'package:ad_drive/data/firestore.dart';
import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/components/popup.dart';
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
import 'dart:ui' as ui;
import 'dart:typed_data';

class MapPresenter extends BasePresenter<MapViewModel> {
  MapPresenter(MapViewModel model) : super(model);

  StreamSubscription? locationSubscription;
  StreamSubscription? pointsSubscription;
  StreamSubscription<Position>? positionSubscription;
  final Location _locationTracker = Location();
  Marker? marker;
  GoogleMapController? controller;
  final Set<Polyline> lines = {};
  List<LatLng> locationListFromStream = [];
  int polylineIdCounter = 0;
  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(43.2385, 76.945656), zoom: 14);
  LatLng lastLocation = const LatLng(43, 76);
  double totalDistance = 0;
  bool isJobAvailable = false;
  Uint8List? customMarker;

  @override
  void onInitWithContext() async {
    super.onInitWithContext();
    if (getJobAvailable()) {
      var location = await _locationTracker.getLocation();
      updateMarker(location);
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
    startLocationStream();
    startStreamOfPoints();
    positionSubscription = Geolocator.getPositionStream().listen((Position position) {
      if (locationListFromStream.isNotEmpty) {
        totalDistance += Geolocator.distanceBetween(
              locationListFromStream.last.latitude,
              locationListFromStream.last.longitude,
              position.latitude,
              position.longitude,
            ) /
            1000;
      }
      locationListFromStream.add(LatLng(position.latitude, position.longitude));
    });
  }

  void startStreamOfPoints() {
    pointsSubscription =
        _locationTracker.onLocationChanged.throttleTime(const Duration(minutes: 2)).listen((event) {
      if (event.latitude != null && event.longitude != null) {
        if ((userScope.latitude.isEmpty && userScope.longitude.isEmpty) ||
            (userScope.latitude.last.toStringAsFixed(4) != event.latitude!.toStringAsFixed(4) &&
                userScope.longitude.last.toStringAsFixed(4) !=
                    event.longitude!.toStringAsFixed(4))) {
          userScope.latitude.add(event.latitude!);
          userScope.longitude.add(event.longitude!);
        }
      }
    });
  }

  Future startLocationStream() async {
    var location = await _locationTracker.getLocation();
    updateMarker(location);
    lastLocation = LatLng(location.latitude!, location.longitude!);
    try {
      locationSubscription = _locationTracker.onLocationChanged
          .throttleTime(const Duration(seconds: 5))
          .listen((event) async {
        if (controller != null) {
          var location = await _locationTracker.getLocation();
          if (lastLocation.latitude.toStringAsFixed(4) != location.latitude?.toStringAsFixed(4) &&
              lastLocation.longitude.toStringAsFixed(4) != location.longitude?.toStringAsFixed(4)) {
            updateMarker(location);
            List<LatLng> list = locationListFromStream.toList();
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

  void updateMarker(LocationData newLocationData) async {
    if (newLocationData.longitude != null &&
        newLocationData.latitude != null &&
        newLocationData.heading != null) {
      LatLng latLng = LatLng(newLocationData.latitude!, newLocationData.longitude!);
      customMarker ??= await getBytesFromAsset(
          path: 'assets/icons/marker.png', //paste the custom image path
          width: 50 // size of custom image as marker
          );
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
          icon: BitmapDescriptor.fromBytes(customMarker!));
      controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
            latLng.latitude,
            latLng.longitude,
          ),
          tilt: 0,
          zoom: 18,
          bearing: 192)));
      updateView();
    }
  }

  void endRide() async {
    startLoading();
    if (model.isLoading) {
      Popups.showPopup(
        title: "Сохраняем данные",
        description: "Это займет не больше 30 секунд",
        context: context,
        isLoading: true,
      );
    }
    cancelStreams();
    final photoUrl = await getUploadPhoto();
    await FireStoreInstance().sendFinishRide(
      uid: userScope.userData.uid,
      photoUrl: photoUrl,
      distance: totalDistance.round(),
      latitude: userScope.latitude,
      longitude: userScope.longitude,
    );
    userScope.isRiding = false;
    userScope.latitude.clear();
    userScope.longitude.clear();
    Navigator.pop(context);
  }

  void takePhoto() async {
    userScope.isRiding = true;
    updateView();
    final photoUrl = await getUploadPhoto();
    await FireStoreInstance().sendStartRide(uid: userScope.userData.uid, photoUrl: photoUrl);
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
    List<String> photoUrl =
        await PhotoUploader(userScopeData: userScope).uploadImageFile([File(photo.path)]);
    return photoUrl.first;
  }

  void cancelStreams() {
    if (locationSubscription != null) {
      locationSubscription!.cancel();
    }
    if (positionSubscription != null) {
      positionSubscription!.cancel();
    }
    if (pointsSubscription != null) {
      pointsSubscription!.cancel();
    }
  }

  Future<Uint8List> getBytesFromAsset({required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void dispose() {
    cancelStreams();
    super.dispose();
  }
}
