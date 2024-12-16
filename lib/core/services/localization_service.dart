import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class LocalizationService {
  static const String _languageKey = 'appLanguage';
  static const String _countryKey = 'appCountry';

  static final LocalizationService _instance = LocalizationService._internal();
  factory LocalizationService() => _instance;
  LocalizationService._internal();

  Future<void> setLanguage(String language) async {
    await StorageService().setString(_languageKey, language);
  }

  Future<void> setCountry(String country) async {
    await StorageService().setString(_countryKey, country);
  }

  String getLanguage() {
    return StorageService().getString(_languageKey) ?? 'en';
  }

  String getCountry() {
    return StorageService().getString(_countryKey) ?? 'US';
  }
}
