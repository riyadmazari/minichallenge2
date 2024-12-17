// lib/core/services/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    await _ensureInitialized();
    return _prefs!.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    await _ensureInitialized();
    return _prefs!.setStringList(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    await _ensureInitialized();
    return _prefs!.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    await _ensureInitialized();
    return _prefs!.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    await _ensureInitialized();
    return _prefs!.setDouble(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  Future<bool> remove(String key) async {
    await _ensureInitialized();
    return _prefs!.remove(key);
  }

  Future<bool> clear() async {
    await _ensureInitialized();
    return _prefs!.clear();
  }

  Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
