import 'package:food_delivery_app/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? typeId;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.typeId,
      this.quantity,
      this.isExist,
      this.time,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    typeId = json['type_id'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductsModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "type_id": this.typeId,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
      "product": this.product!.toJson()
    };
  }
}
