class MapLocation {
  int? _totalSize;
  int? _typeId;
  late List<LocationModel> _locations;
  List<LocationModel> get locations => _locations;

  MapLocation(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._locations = products;
  }

  MapLocation.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    if (json['locations'] != null) {
      _locations = <LocationModel>[];
      json['locations'].forEach((v) {
        _locations.add(LocationModel.fromJson(v));
      });
    }
  }
}

class LocationModel {
  int? id;
  String? addressType;
  String? address;
  double? latitude;
  double? longitude;
  int? typeId;
  String? createdAt;
  String? updatedAt;

  LocationModel(
      {this.id,
      this.addressType,
      this.address,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['address_type'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "address_type": this.addressType,
      "address": this.address,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "type_id": this.typeId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}
