import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/midpoint/mp_product_type_controller.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/models/product_type_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../base/empty_cart_page.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/big_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
    List<String> productInfo = [];
    List<String> orderedProducts = [];

    void _placeOrder(List<CartModel> cartModel, CartController cartController) {
      ProductTypeModel productTypeModel = ProductTypeModel();
      OrderModel orderModel = OrderModel();
      int productTypeListLength =
          Get.find<MpProductTypeController>().mpProductTypeList.length;

      for (int i = 0; i < cartController.getItems.length; i++) {
        productInfo = [];
        productInfo.add("Product: ${cartController.getItems[i].name!}");
        for (int j = 0; j < productTypeListLength; j++) {
          productTypeModel =
              Get.find<MpProductTypeController>().mpProductTypeList[j];
          if (productTypeModel.id == cartModel[i].product?.typeId) {
            productInfo.add("Category: ${productTypeModel.title!}");
          }
        }
        productInfo.add("Price: ${cartController.getItems[i].price}");
        productInfo.add("Quantity: ${cartController.getItems[i].quantity}");
        orderedProducts.add(productInfo.toString());
      }

      orderModel.tableNumber = 3;
      orderModel.orderDescription = orderedProducts;
      orderModel.totalPrice = cartController.totalAmount.toDouble();
      orderModel.restaurantId = Get.find<LocationController>().locationModel.id;
      Get.find<UserController>().getUserInfo();
      orderModel.userId = Get.find<UserController>().userModel?.id;

      Get.find<OrderController>().postOrder(orderModel);
    }

    return GetBuilder<CartController>(builder: (cartController) {
      var _cartList = cartController.getItems;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.orangeColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Column(
            children: [
              const Text(
                "Your Cart",
                style: TextStyle(color: Colors.white),
              ),
              Text("${cartController.getItems.length} items",
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
        body: cartController.getItems.length > 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (context, index) {
                      _index = index;
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimensions.height10),
                        child: Dismissible(
                          key:
                              Key(cartController.getItems[index].id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 250, 199, 199),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15)),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset("assets/icon/Trash.svg")
                              ],
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              cartController.addItem(_cartList[index].product!,
                                  -cartController.getItems[index].quantity!);
                            });
                          },
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // var popularIndex =
                                  //     Get.find<PopularProductController>()
                                  //         .popularProductList
                                  //         .indexOf(_cartList[index].product!);
                                  // if (popularIndex >= 0) {
                                  //   Get.toNamed(RouteHelper.getPopularFood(
                                  //       popularIndex, "cartpage"));
                                  // } else {
                                  //   var recommendedIndex =
                                  //       Get.find<RecommendedProductController>()
                                  //           .recommendedProductList
                                  //           .indexOf(_cartList[index].product!);
                                  //   if (recommendedIndex < 0) {
                                  //     Get.snackbar("History product",
                                  //         "Product review is not available for history products",
                                  //         backgroundColor: Colors.grey[50],
                                  //         colorText: Colors.black54);
                                  //   } else {
                                  //     Get.toNamed(
                                  //         RouteHelper.getRecommendedFood(
                                  //             recommendedIndex, "cartpage"));
                                  //   }
                                  // }
                                },
                                child: SizedBox(
                                  width: Dimensions.width20 * 4.2,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartController
                                                          .getItems[index]
                                                          .img!))),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartController.getItems[index].name!,
                                    style: TextStyle(
                                        fontSize: Dimensions.font16,
                                        color: Colors.black),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Text.rich(TextSpan(
                                    text:
                                        "\$${cartController.getItems[index].price}",
                                    style:
                                        TextStyle(color: AppColors.orangeColor),
                                  )),
                                  SizedBox(height: Dimensions.height10),
                                  SizedBox(
                                    width: Dimensions.width30 * 3,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.height10 / 2.5,
                                            bottom: Dimensions.height10 / 2.5,
                                            left: Dimensions.width10 / 3,
                                            right: Dimensions.width10 / 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.orangeColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cartController.addItem(
                                                    _cartList[index].product!,
                                                    -1);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: Dimensions.iconSize16,
                                              ),
                                            ),
                                            Text(
                                              cartController
                                                  .getItems[index].quantity
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: Dimensions.font16,
                                                  color: Colors.black),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.addItem(
                                                    _cartList[index].product!,
                                                    1);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: Dimensions.iconSize16,
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : const EmptyCartPage(text: "Your cart is empty!"),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.height15, horizontal: Dimensions.width30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.5)),
              ]),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.height10),
                      height: Dimensions.height20 * 2,
                      width: Dimensions.width20 * 2,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20 / 2),
                      ),
                      child: SvgPicture.asset("assets/icon/receipt.svg"),
                    ),
                    Spacer(),
                    Text("Add voucher code"),
                    SizedBox(width: Dimensions.width10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: Dimensions.iconSize24 / 2,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(text: "Total:\n", children: [
                      TextSpan(
                          text: "\$${cartController.totalAmount.toString()}",
                          style: TextStyle(
                              fontSize: Dimensions.font16, color: Colors.black))
                    ])),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          if (Get.find<LocationController>().isThere) {
                            cartController.addToHistory();
                            _placeOrder(
                                cartController.getItems, cartController);
                          } else {
                            _placeOrder(
                                cartController.getItems, cartController);
                            Get.snackbar('Location Error',
                                'Your Location does not seem to be in the right place',
                                colorText: Colors.black54,
                                backgroundColor: Colors.grey[50]);
                          }
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: SizedBox(
                        width: Dimensions.width10 * 19,
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
                          child: Center(
                            child: BigText(
                              text: "Check Out",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
