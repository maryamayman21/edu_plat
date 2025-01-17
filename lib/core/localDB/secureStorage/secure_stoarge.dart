import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Static instance of FlutterSecureStorage
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Write data to secure storage
  static Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Read data from secure storage
  static Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete data from secure storage
  static Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Check if a key exists
  static Future<bool> containsKey(String key) async {
    return (await _secureStorage.containsKey(key: key)) ?? false;
  }

  /// Delete all data in secure storage
  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
