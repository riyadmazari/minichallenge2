// lib/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minichallenge2/features/details/pages/actor_detail_screen.dart';
import 'package:minichallenge2/features/details/pages/movie_detail_screen.dart';
import 'package:minichallenge2/features/details/pages/tv_show_detail_screen.dart';
import 'package:minichallenge2/features/home/pages/home_screen.dart';
import 'package:minichallenge2/features/profile/pages/user_profile_screen.dart';
import 'package:minichallenge2/features/profile/pages/watchlist_screen.dart';
import 'package:minichallenge2/features/profile/pages/rated_list_screen.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          path: '/watchlist',
          name: 'watchlist',
          builder: (context, state) => const WatchlistScreen(),
        ),
        GoRoute(
          path: '/rated',
          name: 'rated',
          builder: (context, state) => const RatingScreen(),
        ),
        GoRoute(
          path: '/movie/:id',
          name: 'movie_detail',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id']!);
            return id != null
                ? MovieDetailScreen(movieId: id)
                : const Scaffold(
                    body: Center(child: Text('Invalid Movie ID')),
                  );
          },
        ),
        GoRoute(
          path: '/tvshow/:id',
          name: 'tv_show_detail',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id']!);
            return id != null
                ? TVShowDetailScreen(tvId: id)
                : const Scaffold(
                    body: Center(child: Text('Invalid TV Show ID')),
                  );
          },
        ),
        GoRoute(
          path: '/actor/:id',
          name: 'actor_detail',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id']!);
            return id != null
                ? ActorDetailScreen(personId: id)
                : const Scaffold(
                    body: Center(child: Text('Invalid Actor ID')),
                  );
          },
        ),
        GoRoute(
          path: '/ratings',
          name: 'ratings',
          builder: (context, state) => const RatingScreen(),
        ),
      ],
    );
  }
}
