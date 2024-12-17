import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile _profile = UserProfile(
    userName: 'Guest',
    isDarkTheme: false,
    country: 'US',
    language: 'en',
    subscribedServices: [],
  );

  UserProfile get profile => _profile;

  UserProfileProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _profile = UserProfile(
      userName: prefs.getString('userName') ?? 'Guest',
      isDarkTheme: prefs.getBool('isDarkTheme') ?? false,
      country: prefs.getString('country') ?? 'US',
      language: prefs.getString('language') ?? 'en',
      subscribedServices: prefs.getStringList('subscribedServices') ?? [],
    );
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    _profile = profile;
    await prefs.setString('userName', profile.userName);
    await prefs.setBool('isDarkTheme', profile.isDarkTheme);
    await prefs.setString('country', profile.country);
    await prefs.setString('language', profile.language);
    await prefs.setStringList('subscribedServices', profile.subscribedServices);
    notifyListeners();
  }

  Future<void> toggleDarkTheme(bool isDark) async {
    _profile = _profile.copyWith(isDarkTheme: isDark);
    await updateProfile(_profile);
  }
}
