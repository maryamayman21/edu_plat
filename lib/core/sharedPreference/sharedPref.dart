import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Private constructor
  SharedPreferencesService._internal();

  // Singleton instance
  static final SharedPreferencesService _instance =
  SharedPreferencesService._internal();

  // Factory constructor to return the singleton instance
  factory SharedPreferencesService() => _instance;

  // SharedPreferences instance
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // Getter for the SharedPreferences instance
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('SharedPreferencesService not initialized. Call init() first.');
    }
    return _prefs!;
  }
}
