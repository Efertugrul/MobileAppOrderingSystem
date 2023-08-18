import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RestaurantRepo extends GetxService {
  final ApiClient apiClient;

  RestaurantRepo({required this.apiClient});

  Future<Response> getRestaurantList() async {
    return await apiClient.getData(AppConstants.RESTAURANTS_URI);
  }
}
