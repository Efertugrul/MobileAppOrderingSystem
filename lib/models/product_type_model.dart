class ProductType {
  int? _totalSize;
  int? _parentId;
  late List<ProductTypeModel> _productTypes;
  List<ProductTypeModel> get productTypes => _productTypes;

  ProductType({required totalSize, required parentId, required productTypes}) {
    this._totalSize = totalSize;
    this._parentId = parentId;
    this._productTypes = productTypes;
  }

  ProductType.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _parentId = json['parent_id'];
    if (json['product_types'] != null) {
      _productTypes = <ProductTypeModel>[];
      json['product_types'].forEach((v) {
        _productTypes.add(ProductTypeModel.fromJson(v));
      });
    }
  }
}

class ProductTypeModel {
  int? id;
  String? title;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  int? order;
  String? description;
  String? img;

  ProductTypeModel(
      {this.id,
      this.title,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.order,
      this.description,
      this.img});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "parent_id": this.parentId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "order": this.order,
      "description": this.description,
      "img": this.img
    };
  }
}
