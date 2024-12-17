// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/api/tmdb_api_service.dart';
import 'core/api/tmdb_repository.dart';
import 'core/providers/search_provider.dart';
import 'core/providers/trending_provider.dart';
import 'core/providers/watchlist_provider.dart';
import 'core/providers/rated_provider.dart';
import 'core/providers/user_profile_provider.dart';
import 'core/providers/theme_provider.dart'; // Import ThemeProvider
import 'router/app_router.dart';

// Import Hive Models and Adapters
import 'core/models/tv_show.dart';
import 'core/models/watchlist_item.dart';
import 'core/models/movie.dart';
import 'core/models/rating.dart';
import 'core/models/user_profile.dart';
// No need for settings model since we're storing a simple boolean

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(TVShowAdapter());
  Hive.registerAdapter(WatchlistItemAdapter());
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(RatingAdapter());
  Hive.registerAdapter(UserProfileAdapter());

  // Open Hive boxes
  await Hive.openBox<WatchlistItem>('watchlist');
  await Hive.openBox<Rating>('ratings');
  await Hive.openBox<UserProfile>('userProfile');
  await Hive.openBox('settings'); // Open a box for settings

  // Initialize TMDBRepository
  final tmdbRepository = TMDBRepository(TMDBApiService());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrendingProvider(tmdbRepository)),
        ChangeNotifierProvider(create: (_) => SearchProvider(tmdbRepository)),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
        ChangeNotifierProvider(create: (_) => RatedProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Add ThemeProvider
        Provider<TMDBRepository>.value(value: tmdbRepository),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Movie App',
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          routerDelegate: _appRouter.router.routerDelegate,
          routeInformationParser: _appRouter.router.routeInformationParser,
          routeInformationProvider: _appRouter.router.routeInformationProvider,
        );
      },
    );
  }
}
