import 'dart:math';
import 'package:food_delivery_app/data/repository/location_repo.dart';
import 'package:food_delivery_app/models/location_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  List<dynamic> _midpointLocationList = [];
  List<dynamic> get midpointLocationList => _midpointLocationList;

  Placemark _locationPlaceMark = Placemark();
  Placemark get locationPlaceMark => _locationPlaceMark;

  double _minDistanceVal = 0;
  double get minDistanceVal => _minDistanceVal;

  LocationModel _locationModel = LocationModel();
  LocationModel get locationModel => _locationModel;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isThere = false;
  bool get isThere => _isThere;

  Future<void> getMidpointLocationList() async {
    Response response = await locationRepo.getMidpointLocationList();
    if (response.statusCode == 200) {
      _midpointLocationList = [];
      _midpointLocationList
          .addAll(MapLocation.fromJson(response.body).locations);
      _isLoaded = true;
      update();
    } else {
      print("ERROR! (LocationController)");
    }
  }

  Future<void> getDistance(Position currentPosition) async {
    List<double> distanceList = [];
    double distance;
    //double latitude = 40.985954771904666;
    //double longitude = 29.1023163995026;

    getMidpointLocationList();

    for (int i = 0; i <= midpointLocationList.length - 1; i++) {
      _locationModel = midpointLocationList[i];
      distance = calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          _locationModel.latitude,
          _locationModel.longitude);
      distanceList.add(distance);
    }
    _minDistanceVal = distanceList[0];
    var minValIndex = 0;

    for (var j = 0; j < distanceList.length; j++) {
      if (distanceList[j] < _minDistanceVal) {
        _minDistanceVal = distanceList[j];
        minValIndex = j;
      }
    }
    if (_minDistanceVal < 0.1) {
      _isThere = true;
    }
    _locationModel = midpointLocationList[minValIndex];
    update();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    double latitude = 40.985954771904666;
    double longitude = 29.1023163995026;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    _locationPlaceMark = placemarks[0];
  }
}
