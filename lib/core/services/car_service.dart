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
  bool _update = false;
  int _currentPage = 0;
  List<Car> listData = [];
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

  int get currentPage => this._currentPage;
  set currentPage(int value) {
    this._currentPage = value;
    notifyListeners();
  }

  bool get update => this._update;
  set update(bool value) {
    this._update = value;
  }

  Future<CarResponse> create(Car car) async {
    loading = true;

    try {
      final token = await AppService.getToken();
      final data = car.toJson();

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
    } catch (ex) {
      loading = false;
      return CarResponse(ok: false);
    }
  }

  Future<CarResponse> edit(Car car) async {
    loading = true;

    try {
      final token = await AppService.getToken();
      final data = car.toJson();

      final resp = await http.put('${Enviroment.apiUrl}/car/',
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );
      
      loading = false;
      if (resp.statusCode == 200) {
        final carResponse = carResponseFromJsonEdit(resp.body);
        car.uui = carResponse.data.uui;
        return carResponse;
      } else {
        return CarResponse(ok: false);
      }
    } catch (ex) {
      loading = false;
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

  Future<CarAllResponse> getAll({String page = '1', Map<String, dynamic> filters}) async {
    loading = true;
    final token = await AppService.getToken();

    try {
      final resp = await http.get('${Enviroment.apiUrl}/car?page=$page',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'filters': jsonEncode(filters)
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
    } catch(e) {
      return CarAllResponse(
        ok: false
      );
    }
  }

  Future<CarAllResponse> getUserAll(String id, {String page = '1'}) async {
    final token = await AppService.getToken();

    final resp = await http.get('${Enviroment.apiUrl}/user/$id/car?page=$page',
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