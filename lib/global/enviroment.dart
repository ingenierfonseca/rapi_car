import 'dart:io';

class Enviroment {
  static bool isLocal = false;
  static String url = !Enviroment.isLocal
    ? 'https://rapi-car-backend.herokuapp.com' 
    : Platform.isAndroid 
    ? 'http://10.0.2.2:3000' 
    : 'http://localhost:3000';
  
  static String apiUrl = '${url}/api';
  static String userUrl = '${url}/uploads/users';
  static String carUrl = '${url}/uploads/cars';
}