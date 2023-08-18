import 'package:food_delivery_app/models/order_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> postOrder(OrderModel orderModel) async {
    return await apiClient.postData(
        AppConstants.ORDER_URI, orderModel.toJson());
  }
}
