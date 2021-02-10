import 'dart:convert';
import 'package:rapi_car_app/core/models/car.dart';

CarResponse carResponseFromJson(String str) => CarResponse.fromJson(json.decode(str));

String carResponseToJson(CarResponse data) => json.encode(data.toJson());

class CarResponse {
    CarResponse({
        this.ok,
        this.msg,
        this.data,
    });

    bool ok;
    String msg;
    Car data;

    factory CarResponse.fromJson(Map<String, dynamic> json) => CarResponse(
        ok: json["ok"],
        msg: json["msg"],
        data: Car.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "data": data.toJson(),
    };
}