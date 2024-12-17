// lib/features/profile/pages/rated_list_screen.dart

import 'package:flutter/material.dart';
import 'package:minichallenge2/features/details/pages/movie_detail_screen.dart';
import 'package:minichallenge2/features/details/pages/tv_show_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/rated_provider.dart';
import '../../../core/providers/watchlist_provider.dart';
import '../../../core/models/rating.dart';
import '../../../core/models/watchlist_item.dart';


class RatedListScreen extends StatelessWidget {
  const RatedListScreen({Key? key}) : super(key: key);

  void _navigateToDetail(BuildContext context, Rating rating, WatchlistProvider watchlistProvider) {
    if (rating.isMovie) {
      // Check if the movie is in the watchlist
      final watchlistItem = watchlistProvider.items.firstWhere(
        (w) => w.id == rating.id && w.isMovie,
        orElse: () => WatchlistItem(
          id: rating.id,
          isMovie: true,
          title: rating.title,
          posterPath: rating.posterPath,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: watchlistItem.id)),
      );
    } else {
      // Check if the TV show is in the watchlist
      final watchlistItem = watchlistProvider.items.firstWhere(
        (w) => w.id == rating.id && !w.isMovie,
        orElse: () => WatchlistItem(
          id: rating.id,
          isMovie: false,
          title: rating.title,
          posterPath: rating.posterPath,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TVShowDetailScreen(tvId: watchlistItem.id)),
      );
    }
  }

  void _showRatingDialog(BuildContext context, RatedProvider ratedProvider, Rating rating) {
    double _currentRating = rating.userRating;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Rating for ${rating.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Rating: ${_currentRating > 0 ? _currentRating.toInt() : 'Not rated'}',
                style: const TextStyle(fontSize: 18),
              ),
              Slider(
                value: _currentRating > 0 ? _currentRating : 5,
                min: 1,
                max: 10,
                divisions: 9,
                label: _currentRating > 0 ? _currentRating.toInt().toString() : '5',
                onChanged: (double value) {
                  _currentRating = value;
                  // Force rebuild to update label
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentRating > 0) {
                  ratedProvider.addOrUpdateRating(
                    Rating(
                      id: rating.id,
                      isMovie: rating.isMovie,
                      title: rating.title,
                      posterPath: rating.posterPath,
                      userRating: _currentRating,
                    ),
                  );
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratedProvider = Provider.of<RatedProvider>(context);
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final ratedItems = ratedProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Ratings'),
      ),
      body: ratedItems.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('You have not rated any movies or TV shows yet.'),
              ),
            )
          : ListView.builder(
              itemCount: ratedItems.length,
              itemBuilder: (_, index) {
                final rating = ratedItems[index];
                String title = rating.title;
                String posterPath = rating.posterPath;
                String mediaType = rating.isMovie ? 'Movie' : 'TV Show';
                double userRating = rating.userRating;

                return ListTile(
                  leading: posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92$posterPath',
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.image),
                  title: Text(title),
                  subtitle: Text('$mediaType - Rating: ${userRating.toInt()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showRatingDialog(context, ratedProvider, rating);
                    },
                  ),
                  onTap: () => _navigateToDetail(context, rating, watchlistProvider),
                );
              },
            ),
    );
  }
}
