import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/advertisement_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_type_controller.dart';
import 'package:food_delivery_app/controllers/restaurant_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import "package:get/get.dart";
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<UserController>().getUserInfo();
    Get.find<RestaurantController>().getRestaurantList();
    return GetBuilder<AdvertisementController>(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //home: SignInPage(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.routes,
      );
    });
  }
}
