import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image/image.dart' as Img;
import 'package:rapi_car_app/core/models/response/cars_all_response.dart';
import 'package:rapi_car_app/core/models/response/car_response.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/global/enviroment.dart';
import 'package:rapi_car_app/core/models/car.dart';

class CarService with ChangeNotifier, AppService {
  bool _loading = false;
  bool _isEditOrNew = false;
  Car car = null;

  bool get loading => this._loading;
  
  set loading(bool value) {
    this._loading = value;
    notifyListeners();
  }

  bool get isEditOrNew => this._isEditOrNew;
  
  set isEditOrNew(bool value) {
    this._isEditOrNew = value;
    notifyListeners();
  }

  Future<CarResponse> create(String brand, String model, int passengers, String fuelType,
    String transmissionType, double engine, double price, String country_id, String city_id,
    String location, String paths, String user_id
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
      "country": '602309bac41c0953e41b1feb',//country_id,
      "city": '60230b4c244b1a22207cede4',//city_id,
      "user": user_id,
      "location": location
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
      final carResponse = carResponseFromJson(resp.body);
      car.uui = carResponse.data.uui;
      return carResponse;
    } else {
      return CarResponse(ok: false);
    }
  }

  Future<bool> sendImage(String id, String filename, bool isDelete) async {
    final token = await AppService.getToken();
    File file = File(filename);

    Img.Image image_temp = Img.decodeImage(file.readAsBytesSync());
    Img.Image image_resize = Img.copyResize(image_temp, width: 800);
    
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST', Uri.parse('${Enviroment.apiUrl}/upload/cars/$id/$isDelete'),
    );

    Map<String,String> headers={
      'Authorization':'Bearer $token',
      "Content-type": "multipart/form-data"
    };

    request.files.add(
        http.MultipartFile.fromBytes(
           'file',
            Img.encodeJpg(image_resize),//file.readAsBytes().asStream(),
            //file.lengthSync(),
            filename: 'resized_image.jpg'//filename,
          //contentType: MediaType('image','jpeg'),
        ),
    );

    request.headers.addAll(headers);
    request.fields.addAll({
      "name":"test",
      "email":"test@gmail.com",
      "id":"12345"
    });

    final resp = await request.send();
    
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<CarAllResponse> getAll({String page = '1'}) async {
    final token = await AppService.getToken();

    final resp = await http.get('${Enviroment.apiUrl}/car?page=$page',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(resp.body);
    if (resp.statusCode == 200) {
      final carResponse = carAllResponseFromJson(resp.body);

      return carResponse;
    } else {
      return CarAllResponse(
        ok: false
      );
    }
  }
}