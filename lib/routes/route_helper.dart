import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/location/location_map.dart';
import 'package:food_delivery_app/pages/location/location_page.dart';
import 'package:food_delivery_app/pages/midpoint/mp_detail.dart';
import 'package:food_delivery_app/pages/midpoint/mp_main.dart';
import 'package:food_delivery_app/pages/profile/profile_details.dart';
import 'package:food_delivery_app/pages/profile/profile_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String profileDetail = "/profile-detail";
  static const String profilePage = "/profile-page";
  static const String locationPage = "/location-page";
  static const String locationMap = "/location-map";
  static const String mpMainPage = "/mp-main";
  static const String mpDetailPage = "/mp-detail";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getProfileDetailPage() => '$profileDetail';
  static String getProfilePage() => '$profilePage';
  static String getLocationPage() => '$locationPage';
  static String getLocationMapPage() => '$locationMap';
  static String getMpMainPage() => '$mpMainPage';
  static String getMpDetailPage(int pageId, String page) =>
      '$mpDetailPage?pageId=$pageId&page=$page';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(
        name: signIn, page: () => SignInPage(), transition: Transition.fade),
    GetPage(
        name: profileDetail,
        page: () => ProfileSettingsPage(),
        transition: Transition.fade),
    GetPage(
        name: profilePage,
        page: () => ProfilePage(),
        transition: Transition.fade),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: locationPage,
        page: () {
          return LocationPage();
        }),
    GetPage(
        name: locationMap,
        page: () {
          LocationMap _addressMap = Get.arguments;
          return _addressMap;
        }),
    GetPage(
        name: mpMainPage,
        page: () {
          return MpMain();
        }),
    GetPage(
        name: mpDetailPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return MpDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
  ];
}
