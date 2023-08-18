import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_type_controller.dart';
import 'package:food_delivery_app/models/product_type_model.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/location_controller.dart';
import '../../models/location_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';

class MpMain extends StatefulWidget {
  const MpMain({
    Key? key,
  }) : super(key: key);

  @override
  State<MpMain> createState() => _MpMainState();
}

class _MpMainState extends State<MpMain> {
  var selected = 0;
  late ProductTypeModel productType;

  Placemark placemark = Placemark();
  Set<Marker> markers = {};

  late LocationModel _locationModel;
  LocationModel get locationModel => _locationModel;
  late double _minDistanceVal;
  double get minDistanceVal => _minDistanceVal;

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
    Get.find<LocationController>().getDistance(position);
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                height: Dimensions.height20 * 11,
                width: MediaQuery.of(context).size.width,
                image: const AssetImage("assets/image/IMG-1685.JPG"),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height45),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: Dimensions.width15 + Dimensions.width10,
                    right: Dimensions.width15 + Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 8, top: 8, bottom: 8),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 23,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
              GetBuilder<LocationController>(builder: (locationController) {
                return Container(
                    margin: EdgeInsets.only(top: Dimensions.height10 * 20),
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            Dimensions.width20 + Dimensions.width10 / 2),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Midpoint',
                                    style: TextStyle(
                                        fontSize: Dimensions.font26,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: locationController.isThere
                                                ? Colors.green
                                                : Colors.redAccent,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3)),
                                        child: const Text(' Order ',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    SizedBox(width: Dimensions.width10),
                                    Text(
                                        "${locationController.minDistanceVal.toStringAsFixed(3)} Km",
                                        style: TextStyle(
                                            fontSize: Dimensions.font16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    SizedBox(width: Dimensions.width10),
                                    Text('Restaurant',
                                        style: TextStyle(
                                            fontSize: Dimensions.font16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.grey.withOpacity(0.4)))
                                  ],
                                )
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20 + Dimensions.radius30),
                              child: Image.asset(
                                'assets/image/midpoint_logo.jpg',
                                width: Dimensions.width30 * 2.7,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.height10 / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            locationController.locationModel.address != null
                                ? Expanded(
                                    child: Text(
                                      locationController.locationModel.address!,
                                      style: TextStyle(
                                          fontSize: Dimensions.font16),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  )
                                : Text("loading..."),
                            SizedBox(width: Dimensions.width10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_outline,
                                  color: Colors.yellow,
                                ),
                                const Text('4.7',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: Dimensions.width15)
                              ],
                            )
                          ],
                        )
                      ],
                    ));
              })
            ],
          ),
          GetBuilder<MpProductTypeController>(builder: (controller) {
            return Container(
                height: 100,
                color: Colors.grey[50],
                padding: EdgeInsets.symmetric(vertical: Dimensions.height30),
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15 + Dimensions.width10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      productType = controller.mpProductTypeList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                          Get.find<MpProductController>()
                              .getMpProductList(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height10,
                              horizontal:
                                  Dimensions.width10 + Dimensions.width10 / 2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: selected == index
                                  ? AppColors.orangeColor
                                  : Colors.white),
                          child: Text(productType.title!),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) =>
                        SizedBox(width: Dimensions.width20),
                    itemCount: controller.mpProductTypeList.length));
          }),
          GetBuilder<MpProductController>(builder: (controller) {
            return Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15 + Dimensions.width10),
                    color: Colors.grey[50],
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          ProductsModel product =
                              controller.mpProductList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getMpDetailPage(
                                  index, "mp-detail"));
                            },
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20)),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: Dimensions.width10 * 11,
                                    height: Dimensions.height10 * 11,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    product.img!),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15)),
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height20,
                                        left: Dimensions.width10,
                                        right: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(product.name!,
                                                style: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.5)),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: Dimensions.iconSize16,
                                            )
                                          ],
                                        ),
                                        Text(product.description!,
                                            style: TextStyle(
                                              color: AppColors.orangeColor,
                                              height: 1.5,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        SizedBox(
                                            height: Dimensions.height10 / 2),
                                        Text(
                                          '\$${product.price}',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) =>
                            SizedBox(height: Dimensions.height15),
                        itemCount: controller.mpProductList.length)));
          }),
        ],
      ),
    );
  }
}
