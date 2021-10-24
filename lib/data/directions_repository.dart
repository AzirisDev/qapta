import 'package:ad_drive/model/directions.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String googleAPIKey = "AIzaSyA1brj0p5fovQBgh5oEr9QgdHAPWZ0XJWE";

class DirectionsRepository {
  static const String _baseUrl = "https://maps.googleapis.com/maps/api/directions/json?";

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final Response response;
    response = await _dio.get(
      _baseUrl,
      queryParameters: {
        "origin": "${origin.latitude}, ${origin.longitude}",
        "destination": "${destination.latitude}, ${destination.longitude}",
        "key": googleAPIKey,
      },
    );

    return Directions.fromMap(response.data);
  }
}
