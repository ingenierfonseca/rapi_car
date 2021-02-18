import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppService {
  static String TOKEN_KEY = 'token';
  static String LOCATION_KEY = 'location';
  static String PRICE_KEY = 'price';
  static String ORDER_KEY = 'order';
  static String ORDER_ID_KEY = 'order_id';

  //Create storage
  final storage = FlutterSecureStorage();

  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: TOKEN_KEY);
    return token;
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: TOKEN_KEY);
  }

  Future saveToken(String token) async {
    await storage.write(key: TOKEN_KEY, value: token);
  }

  static Future<String> getLocation() async {
    final storage = FlutterSecureStorage();
    final location = await storage.read(key: LOCATION_KEY);
    return location;
  }

  Future saveLocation(String location) async {
    await storage.write(key: LOCATION_KEY, value: location);
  }

  static Future<String> getPrice() async {
    final storage = FlutterSecureStorage();
    final price = await storage.read(key: PRICE_KEY);
    return price;
  }

  Future savePrice(String price) async {
    await storage.write(key: PRICE_KEY, value: price);
  }

  static Future<String> getOrder() async {
    final storage = FlutterSecureStorage();
    final order = await storage.read(key: ORDER_KEY);
    return order;
  }

  Future saveOrder(String order) async {
    await storage.write(key: ORDER_KEY, value: order);
  }

  static Future<int> getOrderId() async {
    final storage = FlutterSecureStorage();
    final order = await storage.read(key: ORDER_ID_KEY);
    return order != null ? int.parse(order) : 1;
  }

  Future saveOrderId(int order) async {
    await storage.write(key: ORDER_ID_KEY, value: order.toString());
  }
}