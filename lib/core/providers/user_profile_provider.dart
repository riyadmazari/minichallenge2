// lib/core/providers/user_profile_provider.dart

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/user_profile.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile? _userProfile;
  late Box<UserProfile> _userProfileBox;

  UserProfile? get userProfile => _userProfile;

  UserProfileProvider() {
    _initUserProfile();
  }

  Future<void> _initUserProfile() async {
    _userProfileBox = Hive.box<UserProfile>('userProfile');
    if (_userProfileBox.isNotEmpty) {
      _userProfile = _userProfileBox.getAt(0);
    } else {
      // Initialize with default values or handle accordingly
      _userProfile = UserProfile(
        userName: 'Guest',
        isDarkTheme: false,
        country: 'USA',
        language: 'English',
        subscribedServices: [],
      );
      await _userProfileBox.add(_userProfile!);
    }
    notifyListeners();
  }

  Future<void> updateUserName(String newUserName) async {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(userName: newUserName);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> toggleDarkTheme() async {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(isDarkTheme: !_userProfile!.isDarkTheme);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> updateCountry(String newCountry) async {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(country: newCountry);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> updateLanguage(String newLanguage) async {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(language: newLanguage);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> updateSubscribedServices(List<String> newSubscribedServices) async {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(subscribedServices: newSubscribedServices);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> addSubscribedService(String service) async {
    if (_userProfile != null && !_userProfile!.subscribedServices.contains(service)) {
      _userProfile!.subscribedServices.add(service);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }

  Future<void> removeSubscribedService(String service) async {
    if (_userProfile != null && _userProfile!.subscribedServices.contains(service)) {
      _userProfile!.subscribedServices.remove(service);
      await _userProfileBox.putAt(0, _userProfile!);
      notifyListeners();
    }
  }
}
