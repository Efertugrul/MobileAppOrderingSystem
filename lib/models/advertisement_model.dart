class Advertisement {
  int? _totalSize;
  int? _typeId;
  late List<AdvertisementModel> _advertisements;
  List<AdvertisementModel> get advertisements => _advertisements;

  Advertisement({required totalSize, required typeId, required ads}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._advertisements = ads;
  }

  Advertisement.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    if (json['ads'] != null) {
      _advertisements = <AdvertisementModel>[];
      json['ads'].forEach((v) {
        _advertisements.add(AdvertisementModel.fromJson(v));
      });
    }
  }
}

class AdvertisementModel {
  int? id;
  String? name;
  String? description;
  String? img;
  String? createdAt;
  String? updatedAt;

  AdvertisementModel(
      {this.id,
      this.name,
      this.description,
      this.img,
      this.createdAt,
      this.updatedAt});

  AdvertisementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": this.id,
  //     "name": this.name,
  //     "description": this.description,
  //     "img": this.img,
  //     "createdAt": this.createdAt,
  //     "updatedAt": this.updatedAt,
  //   };
  // }
}
