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
        this.countryId,
        this.cityId,
        this.location,
        this.classification,
        this.uui,
    });

    List<String> paths;
    String brand;
    String model;
    int passengers;
    String fuelType;
    String transmissionType;
    double engine;
    int price;
    bool available;
    String countryId;
    String cityId;
    String location;
    int classification;
    String uui;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        paths: List<String>.from(json["paths"].map((x) => x)),
        brand: json["brand"],
        model: json["model"],
        passengers: json["passengers"],
        fuelType: json["fuelType"],
        transmissionType: json["transmissionType"],
        engine: json["engine"].toDouble(),
        price: json["price"],
        available: json["available"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        location: json["location"],
        classification: json["classification"],
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
        "country_id": countryId,
        "city_id": cityId,
        "location": location,
        "classification": classification,
        "uui": uui,
    };
}