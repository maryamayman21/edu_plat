
import '../base_cashe_service.dart';

class ProfileCacheService {
  static final ProfileCacheService _instance = ProfileCacheService._internal();
  final BaseCacheService _baseCacheService = BaseCacheService();

  ProfileCacheService._internal();

  factory ProfileCacheService() => _instance;

  Future<void> saveProfile(Map<String, dynamic> profileData) async {
    await _baseCacheService.save('userProfile', profileData);
  }
  Future<void> saveProfilePhoto( String profilePhoto) async {
    await _baseCacheService.save('userProfilePhoto', profilePhoto);
  }
  Future<void> savePhoneNumber(String phoneNumber) async {
    await _baseCacheService.save('userPhoneNumber', phoneNumber);
  }


  Future<Map<String, dynamic>?> getProfile() async {
    return await _baseCacheService.read('userProfile') as Map<String, dynamic>?;
  }
  Future<String?> getProfilePhoto() async {
    print('GOT HERE');
    return await _baseCacheService.read('userProfilePhoto') as  String?;
  }
  Future<String?> getPhoneNumber() async {
    return await _baseCacheService.read('userPhoneNumber') as String?;
  }

  Future<void> clearProfileCache() async {
    await _baseCacheService.delete('userProfile');
  }
  Future<void> clearProfilePhotoCache() async {
    await _baseCacheService.delete('userProfilePhoto');
  }
  Future<void> clearPhoneNumberCache() async {
    await _baseCacheService.delete('userPhoneNumber');
  }
  Future<void> logout() async {
    await _baseCacheService.delete('isLogged');
  }

}
