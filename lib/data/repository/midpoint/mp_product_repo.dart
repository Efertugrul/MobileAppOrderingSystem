import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class MpProductRepo extends GetxService {
  final ApiClient apiClient;

  MpProductRepo({required this.apiClient});

  Future<Response> getMpProductList() async {
    return await apiClient.getData(AppConstants.MP_PRODUCT_URI);
  }
}
