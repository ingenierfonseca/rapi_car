import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rapi_car_app/core/models/response/login_response.dart';
import 'package:rapi_car_app/core/models/user.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/global/enviroment.dart';

class AuthService with ChangeNotifier, AppService {
  User user = null;
  bool _loging = false;

  bool get loging => this._loging;
  
  set loging(bool value) {
    this._loging = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.loging = true;
    
    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${Enviroment.apiUrl}/auth/login/',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.loging = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.data;

      //save token
      await saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String last_name, String email, String password, String password_confirmation) async {
    this.loging = true;
    
    final data = {
      'name': name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation
    };

    final resp = await http.post('${Enviroment.apiUrl}/auth/register/',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.loging = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.data;

      //save token
      await saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await AppService.getToken();

    final resp = await http.get('${Enviroment.apiUrl}/auth/renew/',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.data;
      await saveToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future logout() async {
    await AppService.deleteToken();
  }
}