import 'package:edu_platt/core/localDB/secureStorage/secure_stoarge.dart';

Future<String?> getUserType()async{

  final  String? role = await SecureStorageService.read('role');
  return role;
}