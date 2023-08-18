import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/product_type_model.dart';
import 'package:get/get.dart';

import '../data/repository/restaurant_repo.dart';

class RestaurantController extends GetxController {
  final RestaurantRepo restaurantRepo;

  RestaurantController({required this.restaurantRepo});

  List<dynamic> _restaurantList = [];
  List<dynamic> get restaurantList => _restaurantList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRestaurantList() async {
    Response response = await restaurantRepo.getRestaurantList();
    if (response.statusCode == 200) {
      _restaurantList = [];
      _restaurantList.addAll(ProductType.fromJson(response.body).productTypes);
      _isLoaded = true;
      update();
    } else {
      print("ERROR! (restaurant controller)");
    }
  }
}
