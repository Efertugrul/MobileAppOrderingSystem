class Order {
  int? _totalSize;
  late List<OrderModel> _orders;
  List<OrderModel> get orders => _orders;

  Order({required totalSize, required offset, required products}) {
    this._totalSize = totalSize;
    this._orders = products;
  }

  Order.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['locations'] != null) {
      _orders = <OrderModel>[];
      json['locations'].forEach((v) {
        _orders.add(OrderModel.fromJson(v));
      });
    }
  }
}

class OrderModel {
  int? id;
  int? userId;
  List<String>? orderDescription;
  double? totalPrice;
  int? tableNumber;
  String? orderStatus;
  String? paymentMethod;
  String? paymentStatus;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;

  OrderModel(
      {this.id,
      this.userId,
      this.orderDescription,
      this.totalPrice,
      this.tableNumber,
      this.orderStatus,
      this.paymentMethod,
      this.paymentStatus,
      this.restaurantId,
      this.createdAt,
      this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderDescription = json['order_description'];
    totalPrice = json['total_price'];
    tableNumber = json['table_number'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "user_id": this.userId,
      "order_description": this.orderDescription,
      "total_price": this.totalPrice,
      "table_number": this.tableNumber,
      "order_status": this.orderStatus,
      "payment_method": this.paymentMethod,
      "payment_status": this.paymentStatus,
      "restaurant_id": this.restaurantId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}
