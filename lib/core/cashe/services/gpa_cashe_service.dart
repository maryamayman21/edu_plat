import 'package:edu_platt/core/cashe/base_cashe_service.dart';

class GpaCasheServer{
  static final GpaCasheServer _instance = GpaCasheServer._internal();
  final BaseCacheService _baseCacheService = BaseCacheService();

  GpaCasheServer._internal();
  factory GpaCasheServer() => _instance;

  Future<void> saveGpa(double gpa, ) async {
    await _baseCacheService.save('gpa', {'gpa': gpa});
    print("mmmmmmmmmmkkkkkkkkkkkkk");
  }
  Future<Map<String, double>?> getGpa() async {
    try {
      final gpaData = await _baseCacheService.read('gpa') as Map<dynamic, dynamic>?;

      if (gpaData == null){
        print("null");
        return null;}

      return {'gpa': gpaData['gpa']?.toDouble() ?? 0.0};
    } catch (e) {
      return null;
    }
  }
}