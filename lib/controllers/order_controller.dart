import 'package:food_delivery_app/data/repository/order_repo.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> postOrder(OrderModel orderModel) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.postOrder(orderModel);
    if (response.statusCode == 200) {
      print("Order Placed");
    } else {
      print("ERROR! (order controller)");
    }
    _isLoading = false;
    update();
  }
}
