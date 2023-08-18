import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class AdvertisementRepo extends GetxService {
  final ApiClient apiClient;

  AdvertisementRepo({required this.apiClient});

  Future<Response> getAdvertisementList() async {
    return await apiClient.getData(AppConstants.ADVERTISEMENT_URI);
  }
}
