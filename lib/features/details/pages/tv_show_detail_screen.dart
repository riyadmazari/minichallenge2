// lib/features/details/pages/tv_show_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:minichallenge2/core/models/rating.dart';
import 'package:minichallenge2/features/details/widgets/cast_list.dart';
import 'package:minichallenge2/features/details/widgets/info_section.dart';
import 'package:provider/provider.dart';
import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/providers/watchlist_provider.dart';
import '../../../core/providers/rated_provider.dart';
import '../../../core/models/watchlist_item.dart';

class TVShowDetailScreen extends StatelessWidget {
  final int tvId;
  const TVShowDetailScreen({Key? key, required this.tvId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tmdbRepository = Provider.of<TMDBRepository>(context, listen: false);
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final ratedProvider = Provider.of<RatedProvider>(context);
    final userRating = ratedProvider.getRating(tvId, 'tv');

    return FutureBuilder<TVShow>(
      future: tmdbRepository.getTVDetails(tvId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          final tvShow = snapshot.data!;
          final posterUrl = 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}';
          final isInWatchlist = watchlistProvider.isInWatchlist(tvShow.id, false);

          return Scaffold(
            appBar: AppBar(
              title: Text(tvShow.name),
              actions: [
                IconButton(
                  icon: Icon(
                    isInWatchlist ? Icons.favorite : Icons.favorite_border,
                    color: isInWatchlist ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (isInWatchlist) {
                      watchlistProvider.removeFromWatchlist(tvShow.id, false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Removed from watchlist')),
                      );
                    } else {
                      watchlistProvider.addToWatchlist(
                        WatchlistItem(
                          id: tvShow.id,
                          isMovie: false,
                          title: tvShow.name,
                          posterPath: tvShow.posterPath,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to watchlist')),
                      );
                    }
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  posterUrl.isNotEmpty
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image),
                          ),
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey.shade300,
                          child: const Center(child: Icon(Icons.image)),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InfoSection(
                      title: tvShow.name,
                      overview: tvShow.overview,
                      releaseDate: tvShow.firstAirDate,
                      rating: tvShow.voteAverage,
                      genres: tvShow.genres,
                      runtime: tvShow.episodeRunTime.isNotEmpty ? tvShow.episodeRunTime.first : 0,
                      director: tvShow.director,
                      pegi: tvShow.pegiRating,
                      isTV: true,
                      seasons: tvShow.numberOfSeasons,
                      episodes: tvShow.numberOfEpisodes,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CastList(cast: tvShow.cast.take(5).toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _showRatingDialog(context, ratedProvider, tvShow);
                      },
                      child: Text(userRating > 0
                          ? 'Update Rating: ${userRating.toInt()}'
                          : 'Rate this TV Show'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('No TV show found.')),
          );
        }
      },
    );
  }

  void _showRatingDialog(BuildContext context, RatedProvider ratedProvider, TVShow tvShow) {
    double _currentRating = ratedProvider.getRating(tvShow.id, 'tv');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate TV Show: ${tvShow.name}'),
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
                      id: tvShow.id,
                      category: 'tv',
                      title: tvShow.name,
                      posterPath: tvShow.posterPath,
                      userRating: _currentRating,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rating saved')),
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
}
