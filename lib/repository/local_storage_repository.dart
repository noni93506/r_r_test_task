import 'package:flutter_secure_storage/flutter_secure_storage.dart';


interface class LocalStorageRepository {
  static const String userTokenKey = "APP_USER_TOKEN";
  static const String userPasswordKey = "APP_USER_PASSWORD";
  static const String userEmailKey = "APP_USER_EMAIL";

  final _secureStorage = FlutterSecureStorage();

  Future<void> removeToken() async {
    await _secureStorage.deleteAll();
  }

  Future<String?> readEmail() async {
   return await _secureStorage.read(key: userEmailKey);
  }

  Future<void> saveToken({
    required String token,
    required String email,
  }) async {
    await _secureStorage.write( key: userTokenKey,value:  token);
    await _secureStorage.write( key: userEmailKey,value:  email);
  }
}
