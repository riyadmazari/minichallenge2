class UserProfile {
  final String userName;
  final bool isDarkTheme;
  final String country;
  final String language;
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
}