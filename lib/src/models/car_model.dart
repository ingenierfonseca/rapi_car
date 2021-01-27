import 'package:latlong/latlong.dart';

class CarModel {
  String uniqueId;

  String path;
  String brand;
  String model;
  List<String> paths;
  double price;
  int classification;

  int passengers;
  String fuelType;
  String transmissionType;
  double engine;

  String country = 'Nicaragua';
  String city;
  String address = '';
  LatLng location;
  bool available;

  CarModel({
    this.path,
    this.brand,
    this.model,
    this.paths,
    this.price,
    this.classification,
    this.city,
    this.location,
    this.available,
    this.passengers,
    this.fuelType,
    this.transmissionType,
    this.engine
  });

  CarModel.fromJsonMap( Map<String, dynamic> json ) {
    path                    = json['path'];
    brand                   = json['brand'];
    model                   = json['model'];
    paths                   = json['paths'].cast<String>();
    price                   = json['price'];
    classification          = json['classification'];
    city                    = json['city'];
    location                = strToLatLng(json['location']);
    available               = json['available'];
    passengers              = json['passengers'];
    fuelType                = json['fuelType'];
    transmissionType        = json['transmissionType'];
    engine                  = json['engine'];
  }

  Map<String, dynamic> toJson() => {
    'path':                 path,
    'brand':                brand,
    'model':                model,
    'paths':                paths,
    'price':                price,
    'classification':       classification,
    'city':                 city,
    'location':             location,
    'available':            available,
    'passengers':           passengers,
    'fuelType':             fuelType,
    'transmissionType':     transmissionType,
    'engine':               engine
  };

  LatLng strToLatLng(String loc) {
    var latlong =  loc.split(",");
    double latitude = double.tryParse(latlong[0]);
    double longitude = double.tryParse(latlong[1]);
    return LatLng(latitude, longitude);
  }
}