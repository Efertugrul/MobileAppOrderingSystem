import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/advertisement_model.dart';
import 'package:get/get.dart';
import '../data/repository/advertisement_repo.dart';

class AdvertisementController extends GetxController {
  final AdvertisementRepo advertisementRepo;

  AdvertisementController({required this.advertisementRepo});

  List<dynamic> _advertisementList = [];
  List<dynamic> get advertisementList => _advertisementList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAdvertisementList() async {
    Response response = await advertisementRepo.getAdvertisementList();
    if (response.statusCode == 200) {
      _advertisementList = [];
      _advertisementList
          .addAll(Advertisement.fromJson(response.body).advertisements);
      _isLoaded = true;
      update();
    } else {
      print("ERROR! (advertisement controller)");
    }
  }
}
