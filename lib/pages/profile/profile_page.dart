import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import 'profile_menu.dart';
import 'profile_picture.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: Dimensions.height45 * 1.5),
              BigText(
                text: "Profile",
                color: Colors.grey,
                size: Dimensions.font26,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfilePic(),
              SizedBox(height: Dimensions.height30),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icon/User Icon.svg",
                press: () => {Get.toNamed(RouteHelper.getProfileDetailPage())},
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icon/Bell.svg",
                press: () => {},
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icon/Settings.svg",
                press: () => {},
              ),
              ProfileMenu(
                text: "Location",
                icon: "assets/icon/Question mark.svg",
                press: () => {Get.toNamed(RouteHelper.getLocationPage())},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icon/Log out.svg",
                press: () {
                  if (Get.find<AuthController>().userLoggedIn()) {
                    Get.find<AuthController>().clearSharedData();
                    Get.find<CartController>().clear();
                    //Get.find<CartController>().clearCartHistory();
                    Get.offNamed(RouteHelper.getSignInPage());
                  }
                },
              ),
            ],
          ),
        ));
  }
}
