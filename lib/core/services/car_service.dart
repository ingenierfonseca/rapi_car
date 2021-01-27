import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rapi_car_app/core/models/response/cars_response.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/global/enviroment.dart';

class CarService with ChangeNotifier, AppService {
  bool _loading = false;

  bool get loading => this._loading;
  
  set loading(bool value) {
    this._loading = value;
    notifyListeners();
  }

  Future<bool> create(String brand, String model, int passengers, String fuelType,
    String transmissionType, double engine, double price, String country_id, String city_id,
    String location, String paths
  ) async {
    loading = true;

    final data = {
      "brand": brand,
      "model": model,
      "passengers": passengers,
      "fuelType": fuelType,
      "transmissionType": transmissionType,
      "engine": engine,
      "price": price,
      "country_id": country_id,
      "city_id": city_id,
      "location": location,
      "paths": [
        'https://i.pinimg.com/originals/c5/f9/56/c5f956cd20876e62210debe869270da1.jpg'
      ]
    };

    final token = await AppService.getToken();

    final resp = await http.post('${Enviroment.apiUrl}/car/',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
    
    loading = false;
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<CarResponse> getAll({String page = '1'}) async {
    final token = await AppService.getToken();

    final resp = await http.get('${Enviroment.apiUrl}/car?page=$page',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(resp.body);
    if (resp.statusCode == 200) {
      final carResponse = carResponseFromJson(resp.body);

      return carResponse;
    } else {
      return CarResponse(
        ok: false
      );
    }
  }
}