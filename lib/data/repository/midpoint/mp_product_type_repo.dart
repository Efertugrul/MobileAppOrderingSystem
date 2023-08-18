import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class MpProductTypeRepo extends GetxService {
  final ApiClient apiClient;

  MpProductTypeRepo({required this.apiClient});

  Future<Response> getMpProductTypeList() async {
    return await apiClient.getData(AppConstants.MP_PRODUCT_TYPE_URI);
  }
}
