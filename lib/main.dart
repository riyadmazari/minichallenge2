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
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<UserProfileProvider>().profile;
    return MaterialApp.router(
      title: 'TMDB Flutter App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: profile.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
