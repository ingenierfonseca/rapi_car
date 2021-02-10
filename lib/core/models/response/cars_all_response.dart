import 'dart:convert';

import 'package:rapi_car_app/core/models/car.dart';

CarAllResponse carAllResponseFromJson(String str) => CarAllResponse.fromJson(json.decode(str));

String carAllResponseToJson(CarAllResponse data) => json.encode(data.toJson());

class CarAllResponse {
    CarAllResponse({
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

    factory CarAllResponse.fromJson(Map<String, dynamic> json) => CarAllResponse(
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