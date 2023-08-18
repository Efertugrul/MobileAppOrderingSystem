import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/advertisement_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_type_controller.dart';
import 'package:food_delivery_app/controllers/restaurant_controller.dart';
import 'package:food_delivery_app/models/advertisement_model.dart';
import 'package:food_delivery_app/models/product_type_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../models/products_model.dart';
import '../../widgets/category_card.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (pageController.hasClients) {
        if (_currPageValue < 4) {
          _index++;
          _currPageValue++;
          pageController.animateToPage(
            _currPageValue.toInt(),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeIn,
          );
        } else {
          if (_currPageValue == 4) {
            _currPageValue = 0;
            pageController.animateToPage(
              _currPageValue.toInt(),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selected = 0;
    ProductTypeModel productType;
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icon/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icon/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icon/Game Icon.svg", "text": "Wallet"},
      {"icon": "assets/icon/Gift Icon.svg", "text": "Vouchers"},
      {"icon": "assets/icon/Discover.svg", "text": "Feedback"},
    ];
    return Column(
      children: [
        Container(
          // height: 90,
          width: double.infinity,
          margin: EdgeInsets.all(Dimensions.height20),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20,
            vertical: Dimensions.height15,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF4A3298),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: "A Summer Surpise\n"),
                TextSpan(
                  text: "Cashback 20%",
                  style: TextStyle(
                    fontSize: Dimensions.font26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {},
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.height15),
        //slider section
        GetBuilder<AdvertisementController>(builder: (adsController) {
          return adsController.isLoaded
              ? Container(
                  height: 100,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: adsController.advertisementList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            adsController.advertisementList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots
        SizedBox(height: Dimensions.height20),
        GetBuilder<AdvertisementController>(builder: (adsController) {
          return DotsIndicator(
            dotsCount: adsController.advertisementList.isEmpty
                ? 1
                : adsController.advertisementList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.orangeColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height15),
        Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Restaurants"),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: ".",
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Verified"),
                )
              ],
            )),
        GetBuilder<RestaurantController>(builder: (restaurantController) {
          return Container(
              height: 200,
              color: Colors.grey[50],
              padding: EdgeInsets.symmetric(vertical: Dimensions.height30),
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15 + Dimensions.width10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    productType = restaurantController.restaurantList[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Get.find<MpProductTypeController>()
                              .getmpProductTypeList();
                          Get.find<MpProductController>().getMpProductList(0);
                          Get.toNamed(RouteHelper.getMpMainPage());
                        }
                      },
                      child: Container(
                        width: Dimensions.width20 * 10,
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                Dimensions.width10 + Dimensions.width10 / 2),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                image: NetworkImage(
                                  AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      productType.img!,
                                ),
                                fit: BoxFit.cover),
                            color: Colors.white),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) =>
                      SizedBox(width: Dimensions.width20),
                  itemCount: restaurantController.restaurantList.length));
        }),

        //recommended food
        //list of food and images
        // GetBuilder<MpProductTypeController>(builder: (product) {
        //   return product.isLoaded
        //       ? ListView.builder(
        //           physics: NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           itemCount: product.mpProductTypeList.length,
        //           itemBuilder: (context, index) {
        //             ProductTypeModel recommendedProduct =
        //                 product.mpProductTypeList[index];
        //             return GestureDetector(
        //               onTap: () {
        //                 Get.toNamed(
        //                     RouteHelper.getRecommendedFood(index, "home"));
        //               },
        //               child: Container(
        //                   margin: EdgeInsets.only(
        //                       left: Dimensions.width20,
        //                       right: Dimensions.width20,
        //                       bottom: Dimensions.height10),
        //                   child: Row(
        //                     children: [
        //                       //image section
        //                       Container(
        //                         width: Dimensions.listViewImgSize,
        //                         height: Dimensions.listViewImgSize,
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(
        //                                 Dimensions.radius20),
        //                             color: Colors.white38,
        //                             image: DecorationImage(
        //                                 fit: BoxFit.cover,
        //                                 image: NetworkImage(
        //                                     //AppConstants.IMG_BASE +
        //                                     AppConstants.BASE_URL +
        //                                         AppConstants.UPLOAD_URL +
        //                                         recommendedProduct.img!))),
        //                       ),
        //                       //text container
        //                       Expanded(
        //                         child: Container(
        //                           height: Dimensions.listViewTextContSize,
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.only(
        //                                 topRight: Radius.circular(
        //                                     Dimensions.radius20),
        //                                 bottomRight: Radius.circular(
        //                                     Dimensions.radius20)),
        //                             color: Colors.white,
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.only(
        //                                 left: Dimensions.width10,
        //                                 right: Dimensions.width10),
        //                             child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.center,
        //                               children: [
        //                                 BigText(
        //                                     text: recommendedProduct.title!),
        //                                 SizedBox(
        //                                   height: Dimensions.height10,
        //                                 ),
        //                                 SmallText(text: "With real meat"),
        //                                 SizedBox(
        //                                   height: Dimensions.height10,
        //                                 ),
        //                                 Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     IconAndTextWidget(
        //                                         icon: Icons.circle_sharp,
        //                                         text: "Normal",
        //                                         iconColor:
        //                                             AppColors.iconColor1),
        //                                     IconAndTextWidget(
        //                                         icon: Icons.location_on,
        //                                         text: "1.7km",
        //                                         iconColor: AppColors.mainColor),
        //                                     IconAndTextWidget(
        //                                         icon: Icons.access_time_rounded,
        //                                         text: "32min",
        //                                         iconColor: AppColors.iconColor2)
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   )),
        //             );
        //           })
        //       : CircularProgressIndicator(
        //           color: AppColors.mainColor,
        //         );
        // })
      ],
    );
  }

  Widget _buildPageItem(int index, AdvertisementModel advertisement) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: 200,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          advertisement.img!))),
            ),
          ),
        ],
      ),
    );
  }
}
