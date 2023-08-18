import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/models/location_model.dart';
import 'package:food_delivery_app/pages/location/location_map.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController _currentLocationController = TextEditingController();
  TextEditingController _midpointLocationController = TextEditingController();
  TextEditingController _midpointDistanceController = TextEditingController();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(40.98579, 29.10057), zoom: 17);

  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(40.98579, 29.10057), zoom: 14);
  Set<Marker> markers = {};

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    await Get.find<LocationController>().getMidpointLocationList();
    final result = Get.find<LocationController>().getDistance(position);

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    _currentLocationController.text = '${placemark.name ?? ''}'
        ' '
        '${placemark.locality ?? ''}'
        ' '
        '${placemark.country ?? ''}'
        ' '
        '${placemark.postalCode ?? ''}';
    _midpointLocationController.text =
        Get.find<LocationController>().locationModel.address.toString();
    _midpointDistanceController.text =
        "${Get.find<LocationController>().minDistanceVal.toStringAsFixed(3)} Km";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Current Location"),
          centerTitle: true,
          backgroundColor: AppColors.orangeColor,
        ),
        body: GetBuilder<LocationController>(builder: (locationController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 2, color: AppColors.orangeColor)),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        onTap: (latLng) async {
                          await _determinePosition();
                          Get.toNamed(RouteHelper.getLocationMapPage(),
                              arguments: LocationMap(
                                fromSignup: false,
                                fromAddress: true,
                                googleMapController:
                                    locationController.mapController,
                              ));
                        },
                        zoomControlsEnabled: false,
                        markers: markers,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraMove: ((position) =>
                            _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller) async {
                          googleMapController = controller;
                          locationController.setMapController(controller);
                          await _determinePosition();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Your Location Is:"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                    textController: _currentLocationController,
                    hintText: "Your address",
                    icon: Icons.location_on_outlined),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Closest Midpoint:"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                    textController: _midpointLocationController,
                    hintText: "Midpoint Address:",
                    icon: Icons.location_on_outlined),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Distance to Midpoint:"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                    textController: _midpointDistanceController,
                    hintText: "Distance:",
                    icon: Icons.map_outlined),
              ],
            ),
          );
        }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20 * 7,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.orangeColor),
                      child: BigText(
                        text: "Confirm",
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
