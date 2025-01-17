import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../sharedPreference/sharedPref.dart';

class BaseCacheService {
  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();

  // Save method
  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  // Read method
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null && _isJson(data)) {
      return json.decode(data);
    }
    return null;
  }

  Future<dynamic> readList(String key) async {
    print("step 7");
    final prefs = await SharedPreferences.getInstance();
    print("step 8");

    final data = prefs.getString(key);
    print("step 9");
    print('key $data');

    if (data != null && _isJson(data)) {
      print('data is not null');
      print('data ${json.decode(data)}');
      return json.decode(data);
    }
    return null;
  }


  // Delete method
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Helper method to get the preferences instance
  Future<SharedPreferences> _getPrefs() async {
    final prefs = _sharedPreferencesService.prefs;
    if (prefs == null) {
      print("SharedPreferences is not initialized.");
      throw Exception("SharedPreferences not initialized.");
    }
    return prefs;
  }

  // Check if a string is valid JSON
  bool _isJson(String value) {
    try {
      json.decode(value);
      return true;
    } catch (_) {
      return false;
    }
  }
}
