
import '../../../core/localDB/secureStorage/secure_stoarge.dart';

class TokenService {
  Future<String?> getToken() async {
    return await SecureStorageService.read('token');
  }
  Future<String?> getRule() async {
    return await SecureStorageService.read('role');
  }

  Future<void> saveToken(String token) async {
    await SecureStorageService.write('token', token);
  }

  Future<void> clearToken() async {
    await SecureStorageService.delete('token');
  }
  Future<void> clearRole() async {
    await SecureStorageService.delete('role');
  }
}
