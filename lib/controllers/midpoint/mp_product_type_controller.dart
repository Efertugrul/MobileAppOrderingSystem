import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repository/midpoint/mp_product_type_repo.dart';
import 'package:food_delivery_app/models/product_type_model.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:get/get.dart';

class MpProductTypeController extends GetxController {
  final MpProductTypeRepo mpProductTypeRepo;

  MpProductTypeController({required this.mpProductTypeRepo});

  List<dynamic> _mpProductTypeList = [];
  List<dynamic> get mpProductTypeList => _mpProductTypeList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getmpProductTypeList() async {
    Response response = await mpProductTypeRepo.getMpProductTypeList();
    if (response.statusCode == 200) {
      _mpProductTypeList = [];
      _mpProductTypeList
          .addAll(ProductType.fromJson(response.body).productTypes);
      _isLoaded = true;
      update();
    } else {
      print("ERROR! (mp_product_type controller)");
    }
  }
}
