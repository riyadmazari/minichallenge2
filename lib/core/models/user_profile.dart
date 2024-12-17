// lib/core/models/user_profile.dart

import 'package:hive/hive.dart';

part 'user_profile.g.dart'; // Required for Hive code generation

@HiveType(typeId: 5) // Ensure this typeId is unique across your project
class UserProfile extends HiveObject {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final bool isDarkTheme;

  @HiveField(2)
  final String country;

  @HiveField(3)
  final String language;

  @HiveField(4)
  final List<String> subscribedServices;

  UserProfile({
    required this.userName,
    required this.isDarkTheme,
    required this.country,
    required this.language,
    required this.subscribedServices,
  });

  UserProfile copyWith({
    String? userName,
    bool? isDarkTheme,
    String? country,
    String? language,
    List<String>? subscribedServices,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      country: country ?? this.country,
      language: language ?? this.language,
      subscribedServices: subscribedServices ?? this.subscribedServices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'isDarkTheme': isDarkTheme,
      'country': country,
      'language': language,
      'subscribedServices': subscribedServices,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userName: map['userName'],
      isDarkTheme: map['isDarkTheme'],
      country: map['country'],
      language: map['language'],
      subscribedServices: List<String>.from(map['subscribedServices']),
    );
  }
}
