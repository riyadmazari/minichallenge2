// lib/features/details/pages/movie_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/movie.dart';
import '../widgets/cast_list.dart';
import '../widgets/info_section.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tmdbRepository = Provider.of<TMDBRepository>(context, listen: false);

    return FutureBuilder<Movie>(
      future: tmdbRepository.getMovieDetails(movieId),
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
          final movie = snapshot.data!;
          final posterUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

          return Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
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
                      title: movie.title,
                      overview: movie.overview,
                      releaseDate: movie.releaseDate,
                      rating: movie.rating,
                      genres: movie.genres, // Ensure genres are parsed correctly
                      runtime: movie.runtime, // Ensure runtime is parsed correctly
                      director: movie.director, // Ensure `director` field is present
                      pegi: movie.pegiRating, // Ensure `pegiRating` field is present
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CastList(cast: movie.cast.take(3).toList()), // Pass List<CastMember>
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('No movie found.')),
          );
        }
      },
    );
  }
}
