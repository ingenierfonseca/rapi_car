import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rapi_car_app/src/models/car_model.dart';


class LocalProvider {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future get _localFile async {
    //final path = await _localPath;//$path/
    return await rootBundle.load('assets/data/cars.json');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<void> writeCounter(Map data) async {
    print(jsonEncode(data));
    var filename = 'cars.json';
    final path = (await getApplicationDocumentsDirectory()).path;
    final file = await _localFile;

    writeToFile(file, '$path/$filename');

    // Write the file
    //return file.writeAsString(data);
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<String> _loadCarsAsset() async {
    return await rootBundle.loadString('assets/data/cars.json');
  }

  List<dynamic> _parseJson(String jsonString) {
    return jsonDecode(jsonString);
  }

  Future<List<CarModel>> loadCars() async {
    String jsonString = await _loadCarsAsset();
    //print(jsonString);
    List<dynamic> json = List<dynamic>();

    if (jsonString != null && jsonString != '')
      json = _parseJson(jsonString);

    List<CarModel> cars = List<CarModel>();

    for (var car in json) {
      cars.add(CarModel.fromJsonMap(car));
    }
    return cars;
  }
}