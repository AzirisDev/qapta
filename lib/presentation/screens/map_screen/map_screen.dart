import 'dart:async';
import 'dart:typed_data';

import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_presenter.dart';
import 'package:ad_drive/presentation/screens/map_screen/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  Circle? circle;
  GoogleMapController? _controller;

  static const CameraPosition initialLocation = CameraPosition(target: LatLng(37, -122), zoom: 14);

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/ic_money.svg");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocationData, Uint8List imageData) {
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
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: const CircleId("car"),
          radius: newLocationData.accuracy!,
          zIndex: 1,
          strokeColor: AppColors.PRIMARY_BLUE,
          center: latLng,
          fillColor: AppColors.PRIMARY_BLUE.withAlpha(70));
    }
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((event) {
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(
                event.latitude!,
                event.longitude!,
              ),
              tilt: 0,
              zoom: 18,
              bearing: 192)));
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
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: initialLocation,
            markers: Set.of(marker != null ? [marker!] : []),
            circles: Set.of(circle != null ? [circle!] : []),
            onMapCreated: (controller) => _controller = controller,
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
                panel: const Center(child: Text("This is the sliding Widget")),
                collapsed: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(color: AppColors.MONO_WHITE, borderRadius: radius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "This is the collapsed Widget",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                borderRadius: radius,
              ),
            ],
          ),
        ],
      ),
    );
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
