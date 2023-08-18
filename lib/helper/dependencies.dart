import 'package:food_delivery_app/controllers/advertisement_controller.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_type_controller.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/controllers/restaurant_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/advertisement_repo.dart';
import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/location_repo.dart';
import 'package:food_delivery_app/data/repository/midpoint/mp_product_repo.dart';
import 'package:food_delivery_app/data/repository/midpoint/mp_product_type_repo.dart';
import 'package:food_delivery_app/data/repository/order_repo.dart';
import 'package:food_delivery_app/data/repository/restaurant_repo.dart';
import 'package:food_delivery_app/data/repository/user_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Repos
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find()));
  Get.lazyPut(() => MpProductTypeRepo(apiClient: Get.find()));
  Get.lazyPut(() => MpProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => AdvertisementRepo(apiClient: Get.find()));
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //Controllers
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => MpProductTypeController(mpProductTypeRepo: Get.find()));
  Get.lazyPut(() => MpProductController(mpProductRepo: Get.find()));
  Get.lazyPut(() => AdvertisementController(advertisementRepo: Get.find()));
  Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
