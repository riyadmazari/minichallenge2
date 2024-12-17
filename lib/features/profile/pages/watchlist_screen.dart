// lib/features/profile/pages/watchlist_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/watchlist_provider.dart';
import '../../../core/models/watchlist_item.dart';
import '../../details/pages/movie_detail_screen.dart';
import '../../details/pages/tv_show_detail_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  void _navigateToDetail(BuildContext context, WatchlistItem item) {
    if (item.isMovie) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: item.id)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TVShowDetailScreen(tvId: item.id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final watchlistItems = watchlistProvider.items;

    final movies = watchlistItems.where((item) => item.isMovie).toList();
    final tvShows = watchlistItems.where((item) => !item.isMovie).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (movies.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Movies',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  final movie = movies[index];
                  return ListTile(
                    leading: movie.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.image),
                    title: Text(movie.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        watchlistProvider.removeFromWatchlist(movie.id, true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from watchlist')),
                        );
                      },
                    ),
                    onTap: () => _navigateToDetail(context, movie),
                  );
                },
              ),
            ],
            if (tvShows.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'TV Shows',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tvShows.length,
                itemBuilder: (_, index) {
                  final tvShow = tvShows[index];
                  return ListTile(
                    leading: tvShow.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${tvShow.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.image),
                    title: Text(tvShow.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        watchlistProvider.removeFromWatchlist(tvShow.id, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from watchlist')),
                        );
                      },
                    ),
                    onTap: () => _navigateToDetail(context, tvShow),
                  );
                },
              ),
            ],
            if (watchlistItems.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Your watchlist is empty.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
