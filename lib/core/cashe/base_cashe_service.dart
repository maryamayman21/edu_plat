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
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null && _isJson(data)) {
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
  // Append a key to a tracked list
  // Append a new key to a list stored in SharedPreferences
  Future<void> appendToListKey(String listKey, String newKey) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the existing list (make a copy to ensure it's mutable)
    final existingKeys = List<String>.from(prefs.getStringList(listKey) ?? []);

    // Debug print to trace what’s already stored
    print('📦 Existing keys before append: $existingKeys');

    // Only add if it's not already in the list
    if (!existingKeys.contains(newKey)) {
      existingKeys.add(newKey);
      final success = await prefs.setStringList(listKey, existingKeys);

      if (success) {
        print('✅ Key "$newKey" added to list "$listKey"');
      } else {
        print('❌ Failed to update key list for "$listKey"');
      }
    } else {
      print('ℹ️ Key "$newKey" already exists in "$listKey"');
    }

    // Debug print to confirm final state
    final finalKeys = prefs.getStringList(listKey) ?? [];
    print('📦 Final keys after append: $finalKeys');
  }


// Retrieve all keys stored under a specific list key
  Future<List<String>> getListKeys(String listKey) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getStringList(listKey) ?? [];
    print('✅ Retrieved keys from $listKey: $keys');
    return keys;
  }


}
