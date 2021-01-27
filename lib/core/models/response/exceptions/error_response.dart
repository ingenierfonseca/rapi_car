import 'package:rapi_car_app/core/models/model.dart';

class ErrorResponseException implements Exception {
  String message;
  Model data;

  ErrorResponseException({this.message, this.data});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ErrorResponseException.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ErrorResponseException(
      message: map['message'],
    );
  }
}