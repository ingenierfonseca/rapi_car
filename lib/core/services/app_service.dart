import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppService {
  static String TOKEN_KEY = 'token';

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
}