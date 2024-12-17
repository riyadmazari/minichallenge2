import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/home/pages/home_screen.dart';
import '../features/search/pages/search_sreen.dart';
import '../features/details/pages/movie_detail_screen.dart';
import '../features/details/pages/tv_show_detail_screen.dart';
import '../features/details/pages/actor_detail_screen.dart';
import '../features/profile/pages/user_profile_screen.dart';
import '../features/profile/pages/watchlist_screen.dart';
import '../features/profile/pages/rated_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid Movie ID')),
          );
        }
        return MovieDetailScreen(movieId: id);
      },
    ),
    GoRoute(
      path: '/tv/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid TV Show ID')),
          );
        }
        return TVShowDetailScreen(tvId: id);
      },
    ),
    GoRoute(
      path: '/actor/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid Actor ID')),
          );
        }
        return ActorDetailScreen(personId: id);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (_, __) => const UserProfileScreen(),
    ),
    GoRoute(
      path: '/watchlist',
      builder: (_, __) => const WatchlistScreen(),
    ),
    GoRoute(
      path: '/rated',
      builder: (_, __) => const RatedListScreen(),
    ),
  ],
);
