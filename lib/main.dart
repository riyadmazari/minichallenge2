// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/user_profile_provider.dart';
import 'core/providers/watchlist_provider.dart';
import 'core/providers/rated_provider.dart';
import 'core/providers/trending_provider.dart';
import 'core/providers/search_provider.dart';
import 'core/api/tmdb_api_service.dart';
import 'core/api/tmdb_repository.dart';
import 'core/services/storage_service.dart';
import 'features/home/pages/home_screen.dart'; // Your main home screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage service before running the app
  await StorageService().init();

  // Create API and repository instances
  final apiService = TMDBApiService();
  final repository = TMDBRepository(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
        ChangeNotifierProvider(create: (_) => RatedProvider()),
        ChangeNotifierProvider(create: (_) => TrendingProvider(repository)),
        ChangeNotifierProvider(create: (_) => SearchProvider(repository)),
        Provider<TMDBRepository>.value(value: repository), // Provide TMDBRepository
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp or your custom App Widget
    return MaterialApp(
      title: 'TMDB Flutter App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(), // Replace with your home screen
    );
  }
}
