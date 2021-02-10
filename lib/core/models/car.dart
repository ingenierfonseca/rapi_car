import 'package:rapi_car_app/core/models/city.dart';

class Car {
    Car({
        this.paths,
        this.brand,
        this.model,
        this.passengers,
        this.fuelType,
        this.transmissionType,
        this.engine,
        this.price,
        this.available,
        this.country,
        this.city,
        this.location,
        this.classification,
        this.createdAt,
        this.updatedAt,
        this.uui,
    });

    List<dynamic> paths;
    String brand;
    String model;
    int passengers;
    String fuelType;
    String transmissionType;
    double engine;
    int price;
    bool available;
    City country;
    City city;
    String location;
    int classification;
    DateTime createdAt;
    DateTime updatedAt;
    String uui;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        paths: List<dynamic>.from(json["paths"].map((x) => x)),
        brand: json["brand"],
        model: json["model"],
        passengers: json["passengers"],
        fuelType: json["fuelType"],
        transmissionType: json["transmissionType"],
        engine: json["engine"].toDouble(),
        price: json["price"],
        available: json["available"],
        country: City.fromJson(json["country"]),
        city: City.fromJson(json["city"]),
        location: json["location"],
        classification: json["classification"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uui: json["uui"],
    );

    Map<String, dynamic> toJson() => {
        "paths": List<dynamic>.from(paths.map((x) => x)),
        "brand": brand,
        "model": model,
        "passengers": passengers,
        "fuelType": fuelType,
        "transmissionType": transmissionType,
        "engine": engine,
        "price": price,
        "available": available,
        "country": country.toJson(),
        "city": city.toJson(),
        "location": location,
        "classification": classification,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uui": uui,
    };
}