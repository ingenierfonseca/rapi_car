// To parse this JSON data, do
//
//     final carResponse = carResponseFromJson(jsonString);

import 'dart:convert';

import 'package:rapi_car_app/core/models/car.dart';

CarResponse carResponseFromJson(String str) => CarResponse.fromJson(json.decode(str));

String carResponseToJson(CarResponse data) => json.encode(data.toJson());

class CarResponse {
    CarResponse({
        this.ok,
        this.msg,
        this.car,
        this.totalPages,
        this.currentPage,
    });

    bool ok;
    String msg;
    List<Car> car;
    int totalPages;
    String currentPage;

    factory CarResponse.fromJson(Map<String, dynamic> json) => CarResponse(
        ok: json["ok"],
        msg: json["msg"],
        car: List<Car>.from(json["car"].map((x) => Car.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "car": List<dynamic>.from(car.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
    };
}