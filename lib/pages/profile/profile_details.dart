import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/profile/profile_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';

class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditPage(),
    );
  }
}

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFFFF7643),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width15,
                          top: Dimensions.height15 + Dimensions.height10,
                          right: Dimensions.width15),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: Dimensions.width30 * 4.3,
                                    height: Dimensions.height30 * 4.3,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: Dimensions.width20 / 5,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(0, 10))
                                        ],
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              "assets/image/default_user.png",
                                            ))),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: Dimensions.height20 * 2,
                                        width: Dimensions.width20 * 2,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: Dimensions.width20 / 5,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          color: AppColors.orangeColor,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height45,
                            ),
                            AppTextField(
                                textController: nameController,
                                hintText: userController.userModel?.name,
                                icon: Icons.person,
                                iconColor: AppColors.orangeColor),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            AppTextField(
                                textController: emailController,
                                hintText: userController.userModel?.email,
                                icon: Icons.email,
                                iconColor: AppColors.orangeColor),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            AppTextField(
                              textController: passwordController,
                              hintText: "Password",
                              icon: Icons.password,
                              iconColor: AppColors.orangeColor,
                              isObscure: true,
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            AppTextField(
                                textController: phoneController,
                                hintText: userController.userModel?.phone,
                                icon: Icons.phone,
                                iconColor: AppColors.orangeColor),
                            SizedBox(
                              height: Dimensions.height45 * 2.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  child: const Text("CANCEL",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 2.2,
                                          color: Colors.black)),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: AppColors.orangeColor,
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "SAVE",
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : CustomLoader())
              : SignInPage();
        }));
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
