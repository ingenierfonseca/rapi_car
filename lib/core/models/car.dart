import 'package:rapi_car_app/core/models/city.dart';

class Car {
    Car({
        this.type,
        this.paths,
        this.brand,
        this.model,
        this.year,
        this.passengers,
        this.fuelType,
        this.transmissionType,
        this.mileage,
        this.airConditioner,
        this.musicPlayer,
        this.bluetooth,
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
        this.user
    });

    List<dynamic> paths;
    String type;
    String brand;
    String model;
    String year;
    int passengers;
    String fuelType;
    String transmissionType;
    int mileage;
    bool airConditioner;
    bool musicPlayer;
    bool bluetooth;
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
    String user;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        paths: List<dynamic>.from(json["paths"].map((x) => x)),
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        passengers: json["passengers"],
        fuelType: json["fuelType"],
        transmissionType: json["transmissionType"],
        mileage: json["mileage"],
        airConditioner: json["airConditioner"],
        musicPlayer: json["musicPlayer"],
        bluetooth: json["bluetooth"],
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
        user: json["user"]["_id"]
    );

    factory Car.fromJsonEdit(Map<String, dynamic> json) => Car(
        paths: List<dynamic>.from(json["paths"].map((x) => x)),
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        passengers: json["passengers"],
        fuelType: json["fuelType"],
        transmissionType: json["transmissionType"],
        mileage: json["mileage"],
        airConditioner: json["airConditioner"],
        musicPlayer: json["musicPlayer"],
        bluetooth: json["bluetooth"],
        engine: json["engine"].toDouble(),
        price: json["price"],
        available: json["available"],
        country: City.fromJsonEdit(json["country"]),
        city: City.fromJsonEdit(json["city"]),
        location: json["location"],
        classification: json["classification"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uui: json["uui"],
        user: json["user"]
    );

    Map<String, dynamic> toJson() => {
        "paths": List<dynamic>.from(paths.map((x) => x)),
        "type": type,
        "brand": brand,
        "model": model,
        "year": year,
        "passengers": passengers,
        "fuelType": fuelType,
        "transmissionType": transmissionType,
        "mileage": mileage,
        "airConditioner": airConditioner,
        "musicPlayer": musicPlayer,
        "bluetooth": bluetooth,
        "engine": engine,
        "price": price,
        "available": available,
        "country": country.id,
        "city": city.id,
        "location": location,
        "classification": classification,
        "createdAt": createdAt != null ? createdAt.toIso8601String() : '',
        "updatedAt": updatedAt != null ? updatedAt.toIso8601String() : '',
        "uui": uui,
        "user": user
    };
}