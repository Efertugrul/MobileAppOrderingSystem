import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../utils/app_constants.dart';

class LocationRepo {
  final ApiClient apiClient;

  LocationRepo({required this.apiClient});

  Future<Response> getMidpointLocationList() async {
    return await apiClient.getData(AppConstants.MIDPOINT_ADDRESS_URI);
  }
}
