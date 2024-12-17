// lib/features/profile/pages/rating_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/rated_provider.dart';
import '../../../core/models/rating.dart';
import 'package:go_router/go_router.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  void _navigateToDetail(BuildContext context, Rating rating) {
    if (rating.category == 'movie') {
      context.go('/movie/${rating.id}');
    } else if (rating.category == 'tv') {
      context.go('/tvshow/${rating.id}');
    } else if (rating.category == 'actor') {
      context.go('/actor/${rating.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratedProvider = Provider.of<RatedProvider>(context);
    final movieRatings = ratedProvider.getMovieRatings();
    final tvRatings = ratedProvider.getTvRatings();
    final actorRatings = ratedProvider.getActorRatings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ratings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Movies Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Movies',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            if (movieRatings.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('No movie ratings yet.'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movieRatings.length,
                itemBuilder: (context, index) {
                  final rating = movieRatings[index];
                  return ListTile(
                    leading: rating.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${rating.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.image),
                    title: Text(rating.title),
                    subtitle: Text('Your Rating: ${rating.userRating.toInt()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ratedProvider.removeRating(rating.id, 'movie');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rating removed')),
                        );
                      },
                    ),
                    onTap: () => _navigateToDetail(context, rating),
                  );
                },
              ),

            const Divider(),

            // TV Shows Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TV Shows',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            if (tvRatings.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('No TV show ratings yet.'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tvRatings.length,
                itemBuilder: (context, index) {
                  final rating = tvRatings[index];
                  return ListTile(
                    leading: rating.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${rating.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.image),
                    title: Text(rating.title),
                    subtitle: Text('Your Rating: ${rating.userRating.toInt()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ratedProvider.removeRating(rating.id, 'tv');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rating removed')),
                        );
                      },
                    ),
                    onTap: () => _navigateToDetail(context, rating),
                  );
                },
              ),

            const Divider(),

            // Actors Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Actors',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            if (actorRatings.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('No actor ratings yet.'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actorRatings.length,
                itemBuilder: (context, index) {
                  final rating = actorRatings[index];
                  return ListTile(
                    leading: rating.posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${rating.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.person),
                    title: Text(rating.title),
                    subtitle: Text('Your Rating: ${rating.userRating.toInt()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ratedProvider.removeRating(rating.id, 'actor');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rating removed')),
                        );
                      },
                    ),
                    onTap: () => _navigateToDetail(context, rating),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
